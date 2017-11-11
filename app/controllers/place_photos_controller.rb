class PlacePhotosController < ApplicationController

  def edit
    @place_photo = PlacePhoto.find_by id: params[:id]
  end

  def update
    @place_photo = PlacePhoto.find_by id: params[:id]
    if @place_photo.update(place_photo_params)
      redirect_to edit_place_url(@place_photo.place)
    end
  end

  def destroy
    @place_photo = PlacePhoto.find_by id: params[:id]
    @place_photo.destroy
    redirect_to :back
  end

  private

  def place_photo_params
    params.require(:place_photo).permit(:id, :place_id, :photo)
  end
end
