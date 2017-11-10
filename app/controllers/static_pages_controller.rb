class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      if current_user.admin
        redirect_to admin_path
      else
        @reviews = current_user.feed.paginate page: params[:page], per_page: 4
      end
    end
    @places = Place.all
    @places.each do |p|
      p.update_point
    end
    @users = User.where(admin: false)
  end

  def feed
    if user_signed_in?
      @reviews = current_user.feed.paginate page: params[:page], per_page: 4
    else
      redirect_to root_url
    end
  end

end
