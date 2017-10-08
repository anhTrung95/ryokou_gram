class UsersController < ApplicationController
  before_action :find_user, only: :show

  def index
    @users = User.all
  end

  def show
  end

  private
  def find_user
    @user = User.find_by(id: params[:id])

    return if @user
    flash[:danger] = "User not found."
    redirect_to root_url
  end
end