class LeaderboardController < ApplicationController
  def index
    @top_users = User.order(score: :desc).limit(10)
  end
end
