class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  
  def create
    @micropost = Micropost.find params[:micropost_id]
    @micropost.likes.create(user_id: current_user.id)
    redirect_to request.referrer
  end

  def destroy
    like = current_user.likes.find params[:id]
    micropost = like.micropost
    like.destroy
    redirect_to request.referrer
  end

end
