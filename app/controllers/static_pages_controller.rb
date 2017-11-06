class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      if current_user.admin
        redirect_to admin_path
      end
    end
    @places = Place.paginate page: params[:page]
    @places.each do |p|
      p.update_point
    end
    @users = User.all
  end

end
