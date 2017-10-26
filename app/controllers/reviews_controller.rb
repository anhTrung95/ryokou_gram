class ReviewsController < ApplicationController

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
  end

  def destroy
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
end
