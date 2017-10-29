class PlacesController < ApplicationController
  before_action :find_place, only: %i{show destroy edit update}
  before_action :admin, except: %i{index show}
  def index
    @places = Place.paginate page: params[:page]
    @places.each do |p|
      p.update_point
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(place_params)
    if @place.save
      flash[:success] = "Place created."
      redirect_to @place
    else
      render :new
    end
  end

  def show
    @place.update_point
    if user_signed_in?
      @review = Review.where(user_id: current_user.id, place_id: @place.id)
      if @review.exists?
        @review = @review.first
        @reviews = Review.where(place_id: @place.id).where.not(user_id: current_user.id).paginate(page: params[:page])
      else
        @review = current_user.reviews.build
        @reviews = @place.reviews.paginate(page: params[:page])
      end
    end
  end

  def edit
  end

  def update
    if @place.update_attributes(place_params)
      flash[:success] = "Edit place completed."
      redirect_to @place
    else
      render 'edit'
    end
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

  private

    def place_params
      params.require(:place).permit(:name, :address, :overview, :point)
    end
end
