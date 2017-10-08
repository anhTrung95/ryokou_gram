class UsersController < ApplicationController
    def show
        @user = !params[:id].nil? ? User.find_by(id: params[:id]) : current_user
    end
end
