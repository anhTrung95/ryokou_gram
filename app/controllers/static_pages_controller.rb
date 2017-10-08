class StaticPagesController < ApplicationController
  def home
    @users = User.all
    @places = Place.all
  end
end
