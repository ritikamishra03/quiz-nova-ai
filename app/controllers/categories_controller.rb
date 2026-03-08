class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def show
    @category = params[:name]
    @subcategories = Game::SUBCATEGORIES[@category]
    redirect_to root_path, alert: "Unknown category." if @subcategories.nil?
  end
end
