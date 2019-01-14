class RegistrationsController < Devise::RegistrationsController
  
  protected
  def after_update_path_for resource
    user_path(resource)
  end

  def sign_up_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar, :avatar_cache, :remove_avatar
  end

  def account_update_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar
  end
end
