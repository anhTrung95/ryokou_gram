class StaticPagesController < ApplicationController
  def home
    @users = User.last(5)
    @places = Place.last(5)
  end
end
