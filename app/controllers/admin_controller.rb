class AdminController < ApplicationController
    def index
        @users = User.last(5)
        @places = Place.last(5)
    end
    
    private 
    def admin
        return if current_user.admin
        
        flash[:danger] = "You're not admin"
        redirect_to root_url
    end
end
