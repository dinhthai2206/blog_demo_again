class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @users = @q.result(distinct: true).paginate(page: params[:page], per_page: 15)
  end
  
  def show
    @user = User.find_by id: params[:id]
    @microposts = @user.microposts.paginate(page: params[:page])
    @comment = current_user.comments.build if user_signed_in?
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def correct_user
    @user = User.find params[:id]
    unless current_user? @user
      redirect_to root_url 
      flash[:danger] = t ".cant_edit"
    end
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
