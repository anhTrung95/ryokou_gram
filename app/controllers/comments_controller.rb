class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, only: [:destroy, :edit]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        #format.html { redirect_to  place_path(@comment.review.place), notice: 'Comment was successfully created.' }
        # format.json { render :show, status: :created, location: @comment }
        @new_comment = @comment
        @review = @comment.review
        format.js
      else
        format.html { render :new }
        # format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        @review = @comment.review
        #format.html { redirect_to place_path(@comment.review.place), notice: 'Comment was successfully edited.' }
        #format.json { render :show, status: :ok, location: @comment }
        format.js
      else
        format.html { render :edit }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @review = @comment.review
    @comment.destroy
  end

  def like
    @comment = Comment.find_by id: params[:id]
    @comment.liked_by current_user
    if request.xhr?
      render json: { count: @comment.get_upvotes.size, id: params[:id] }
    else
      redirect_to :back
    end
  end

  def unlike
    @comment = Comment.find_by id: params[:id]
    @comment.unliked_by current_user
    if request.xhr?
      render json: { count: @comment.get_upvotes.size, id: params[:id] }
    else
      redirect_to :back
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :review_id, :content)
    end
end
