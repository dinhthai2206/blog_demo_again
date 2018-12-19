class CommentsController < ApplicationController
  before_action :logged_in_user, only: :create
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new comment_params
    if @comment.save
      redirect_to request.referrer   
    else 
      flash[:danger] = "Comment failed"
      redirect_to request.referrer
    end
  end

  def edit
    @comment = Comment.find_by id: params[:id]
  end
  
  def update
    @comment = Comment.find_by id: params[:id]
    if @comment.update_attributes comment_params
      flash[:success] = "Comment updated"
      redirect_to request.referrer
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find_by id: params[:id]
    @comment.destroy
    redirect_to request.referrer
  end

  private
  def comment_params
    params.require(:comment).permit :content, :micropost_id, :user_id
  end

  def correct_user
    @comment = Comment.find_by id: params[:id]
    unless (@comment.user == current_user) || current_user.admin?
      redirect_to request.referrer
    end
  end
end
