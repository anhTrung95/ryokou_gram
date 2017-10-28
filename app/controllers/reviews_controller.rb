class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :destroy]
  def create
    if user_signed_in?
      @review = current_user.reviews.build(review_params)
      if @review.save
        np = @review.place.point + @review.rate
        @review.place.update_point np
        flash[:success] = "Review created."
        redirect_to @review.place
      else
        flash[:error] = "Please rate the place"
        redirect_to @review.place
      end
    else
      flash[:error] = "Please log in first."
      redirect_to new_user_session_url
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to place_path(@review.place), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    redirect_to place_path(@review.place)
  end

  def like
    @review = Review.find_by id: params[:id]
    @review.liked_by current_user
    redirect_to :back
  end

  def unlike
    @review = Review.find_by id: params[:id]
    @review.unliked_by current_user
    redirect_to :back
  end

  private

    def review_params
      params.require(:review).permit(:rate, :content, :place_id, :tag_list)
    end
    
    def set_review
      @review = Review.find(params[:id])
    end
end
