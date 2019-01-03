class FollowersController < ApplicationController
  def index
    @title = t ".followers"
    @user  = User.find_by id: params[:user_id]
    @users = @user.followers.paginate page: params[:page]
    render "users/show_follow"
  end
end
