class SearchesController < ApplicationController
  def index
    @result = Hash.new
    @result[:places] = Place.load_place_with_name params[:search]
    @result[:reviews] = Review.load_review_with_content params[:search]
    @result[:users] = User.load_user_with_name params[:search]
  end
end
