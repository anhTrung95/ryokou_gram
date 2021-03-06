class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      if current_user.admin
        redirect_to admin_path
      else
        @reviews = current_user.follow_feed
        @reviews = @reviews.order(created_at: :desc).paginate page: params[:page], per_page: 8
      end
    else
      redirect_to static_pages_most_home_path
    end
    @places = Place.all
    @places.each do |p|
      p.update_point
    end
    @users = User.where(admin: false)
    @rank_place = 1
  end
  
  def most_home
    @places = Place.all
    @places.each do |p|
      p.update_point
    end
    @users = User.where(admin: false)
    @rank_place = 1
  end

  def feed
    if user_signed_in?
      @reviews = current_user.follow_feed.paginate page: params[:page], per_page: 8
    else
      redirect_to root_url
    end
  end

end
