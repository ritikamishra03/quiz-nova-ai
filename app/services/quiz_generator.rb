class QuizGenerator
  PROMPT = <<~P
    Generate 1 multiple choice question about %{category}.
    Return ONLY valid JSON, no markdown, no explanation:
    {"question":"...","options":["A. ...","B. ...","C. ...","D. ..."],"correct_answer":"A. ..."}
    correct_answer must exactly match one of the options strings.
  P

  def initialize(category, language: "English")
    @category = category
    @client = OpenAI::Client.new(
      access_token: ENV.fetch("GROQ_API_KEY"),
      uri_base: "https://api.groq.com/openai/v1"
    )
  end

  def generate
    response = @client.chat(
      parameters: {
        model: "llama-3.1-8b-instant",
        max_tokens: 500,
        messages: [{ role: "user", content: format(PROMPT, category: @category) }]
      }
    )
    text = response.dig("choices", 0, "message", "content").strip
    text = text.gsub(/```json|```/, "").strip
    JSON.parse(text)
  rescue JSON::ParserError, StandardError => e
    Rails.logger.error("QuizGenerator error: #{e.message}")
    raise
  end
end
