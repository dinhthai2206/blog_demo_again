class FollowersController < ApplicationController
  def index
    @title = "Followers"
    @user  = User.find_by id: params[:user_id]
    @users = @user.followers.paginate page: params[:page]
    render "users/show_follow"
  end
end
