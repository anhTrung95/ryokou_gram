class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      if current_user.admin
        redirect_to admin_path
      end
      @review = current_user.reviews.build
    end
  end
end
