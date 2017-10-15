class ReviewsController < ApplicationController

  def create
    if user_signed_in?
      @review = current_user.reviews.build(review_params)
      if @review.save
        flash[:success] = "Review created."
        redirect_to root_url
      else
        render 'static_pages/home'
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

  private

    def review_params
      params.require(:review).permit(:rate, :content)
    end
end