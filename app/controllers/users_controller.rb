class UsersController < ApplicationController
  before_action :find_user, only: :show

  def index
    @users = User.all
  end

  def show
    @reviews = @user.reviews.paginate(page: params[:page])
  end

  def following
    @title = "Following"
    @user  = User.find_by(id: params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Following"
    @user  = User.find_by(id: params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def find_user
    @user = User.find_by(id: params[:id])

    return if @user
    flash[:danger] = "User not found."
    redirect_to root_url
  end
end
