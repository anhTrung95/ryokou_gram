class PlacesController < ApplicationController
  before_action :find_place, only: %i{show destroy}
  before_action :admin, except: %i{index show}
  def index
    @places = Place.paginate page: params[:page]
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new params.require(:place).permit(:name, :address, :overview)
    if @place.save
      flash[:success] = "Place created."
      redirect_to places_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @place.destroy
    flash[:success] = "Place deleted success."
    redirect_to places_url
  end

  private
  def find_place
    @place = Place.find_by(id: params[:id])

    return if @place
    flash[:danger] = "Place not exist!"
    redirect_to root_url
  end

  def admin
    return if current_user.admin

    flash[:danger] = "You are not admin."
    redirect_to places_url
  end
end