class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @microposts = Micropost.all
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t ".success"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def update
    if @micropost.update_attributes micropost_params
      flash[:success] = t ".updated_success"
      redirect_to request.referrer
    else
      render :edit
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = t ".post_deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end
