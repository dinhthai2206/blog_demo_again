class CommentsController < ApplicationController
  before_action :find_comment, only: %i(edit update destroy)
  before_action :authenticate_user!, only: :create
  before_action :correct_user, only: %i(edit update destroy)

  def edit
    @micropost = @comment.micropost
    respond_to do |format|
      format.html
      format.js
    end  
  end

  def create
    @comment = current_user.comments.build comment_params
    @micropost = @comment.micropost
    if @comment.save
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else
      flash[:danger] = t ".failed"
      redirect_to request.referrer
    end
  end

  def update
    @micropost = @comment.micropost
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else
      redirect_to request.referrer
    end
  end

  def destroy
    @micropost = @comment.micropost
    @comment.destroy
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  private

  def find_comment
    @comment = Comment.find_by id: params[:id]
  end

  def comment_params
    params.require(:comment).permit :content, :micropost_id
  end

  def correct_user
    @comment = Comment.find_by id: params[:id]
    unless (@comment.user == current_user) || current_user.admin?
      redirect_to request.referrer
    end
  end
end
