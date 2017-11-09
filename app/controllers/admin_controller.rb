class AdminController < ApplicationController
    before_action :admin
    
    def index
        
        @users = User.last(5)
        @places = Place.last(5)
        @reviews = Review.last(5)
        @index_page = true
    end
    
    private
    
    def admin
        return if current_user.admin
        
        flash[:danger] = "You're not admin"
        redirect_to root_url
    end
end
