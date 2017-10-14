class StaticPagesController < ApplicationController
  def home
    @users = User.last(5)
    @places = Place.last(5)
    if user_signed_in?
      @review = current_user.reviews.build
    end
  end
end
