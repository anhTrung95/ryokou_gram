class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :destroy, :update]

  def index
     @reviews = Review.order(created_at: :desc).paginate(page: params[:page], :per_page => 20)
  end
  def create
    if user_signed_in?
      @review = current_user.reviews.build(review_params)
      if @review.save
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
    if @review.update_attributes(review_params)
      flash[:success] = "Edit review completed."
      redirect_to @review.place
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to place_path(@review.place)
  end

  def like
    @review = Review.find_by id: params[:id]
    @review.liked_by current_user
    if request.xhr?
      render json: { count: @review.get_upvotes.size, id: params[:id] }
    else
      redirect_to :back
    end
  end
  
    def show
      @reviews = Review.find(params[:id])
    end
    
  def unlike
    @review = Review.find_by id: params[:id]
    @review.unliked_by current_user
    if request.xhr?
      render json: { count: @review.get_upvotes.size, id: params[:id] }
    else
      redirect_to :back
    end
  end
  
  private

    def review_params
      params.require(:review).permit(:rate, :content, :place_id, :tag_list)
    end

    def set_review
      @review = Review.find(params[:id])
    end
    
   
end
