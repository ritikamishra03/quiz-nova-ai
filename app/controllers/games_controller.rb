class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:show, :answer, :result, :next_question, :hint]

  def create
    category = params[:category].presence || params[:custom_category].presence
    return redirect_to root_path, alert: "Please select or enter a category." if category.blank?

    @game = current_user.games.create!(
      category:       category,
      question_limit: params[:question_limit].presence&.to_i || 10,
      time_limit:     params[:time_limit].presence&.to_i,
      language:       "English"
    )
    unless load_new_question(@game)
      redirect_to root_path, alert: "Could not generate question. Set GROQ_API_KEY and try again."
      return
    end

    redirect_to @game
  rescue ActiveRecord::RecordInvalid
    redirect_to root_path, alert: "Could not start game. Please try again."
  end

  def show
    @question_data = session[:current_question]
    return redirect_to root_path, alert: "No question found." if @question_data.nil?
  end

  def answer
    question_data = session[:current_question]
    return redirect_to root_path, alert: "Session expired." if question_data.nil?

    is_correct = normalize_answer(params[:answer]) == normalize_answer(question_data["correct_answer"])
    points     = @game.record_answer(correct: is_correct)
    current_user.add_score(points) if is_correct

    session[:last_result] = {
      "submitted_answer" => params[:answer],
      "correct_answer"   => question_data["correct_answer"],
      "is_correct"       => is_correct,
      "points_earned"    => points
    }
    redirect_to result_game_path(@game)
  end

  def result
    @result_data   = session[:last_result]
    @question_data = session[:current_question]
    return redirect_to root_path, alert: "No result found." if @result_data.nil?
  end

  def hint
    question_data = session[:current_question]
    return render json: { error: "No question loaded." }, status: :not_found if question_data.nil?

    client = OpenAI::Client.new(
      access_token: ENV.fetch("GROQ_API_KEY"),
      uri_base: "https://api.groq.com/openai/v1"
    )
    prompt = "Give a short helpful hint (1-2 sentences) for this quiz question WITHOUT revealing the correct answer.\n\nQuestion: #{question_data['question']}\nOptions: #{question_data['options'].join(', ')}"
    response = client.chat(parameters: {
      model: "llama-3.1-8b-instant", max_tokens: 120,
      messages: [{ role: "user", content: prompt }]
    })
    hint_text = response.dig("choices", 0, "message", "content").to_s.strip
    render json: { hint: hint_text }
  rescue StandardError => e
    render json: { error: "Could not generate hint." }, status: :unprocessable_entity
  end

  def next_question
    unless load_new_question(@game)
      redirect_to root_path, alert: "Could not generate question. Set GROQ_API_KEY and try again."
      return
    end

    redirect_to @game
  end

  private

  # Strip optional "A. " / "B. " prefix so comparison works regardless of AI format
  def normalize_answer(str)
    str.to_s.sub(/\A[A-Da-d]\.\s+/, "").strip
  end

  def set_game
    @game = current_user.games.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Game not found."
    nil
  end

  def load_new_question(game)
    return false if ENV["GROQ_API_KEY"].blank?

    session[:current_question] = QuizGenerator.new(game.category, language: game.language).generate
    session.delete(:last_result)
    true
  rescue StandardError => e
    Rails.logger.error("Failed to generate question: #{e.message}")
    false
  end
end
