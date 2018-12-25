class Microposts::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_micropost

  def create
    @like = @micropost.likes.find_or_initialize_by user_id: current_user.id
    if @like.save
      respond_to do |format|
        format.html {redirect_to request.referrer}
        format.js
      end
    else
      flash[:danger] = "Like failed"
      redirect_to request.referrer
    end
  end

  def destroy
    @micropost.likes.find_by(user_id: current_user.id).destroy
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  private

  def like_params
    params.require(:comment).permit :micropost_id
  end

  def find_micropost
    @micropost = Micropost.find_by id: params[:micropost_id]
  end
end
