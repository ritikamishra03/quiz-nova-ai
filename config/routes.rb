Rails.application.routes.draw do
  # Avoid boot-time route errors when Devise isn't loaded in this runtime.
  devise_for :users if defined?(Devise)
  root "home#index"

  resources :games, only: [:create, :show] do
    member do
      post :answer
      get  :result
      post :next_question
      get  :hint
    end
  end

  get "/categories/:name", to: "categories#show", as: :category
  get "/leaderboard", to: "leaderboard#index", as: :leaderboard
  get "up" => "rails/health#show", as: :rails_health_check
end
