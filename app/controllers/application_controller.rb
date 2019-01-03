class ApplicationController < ActionController::Base
  before_action :search
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def search 
    @q = User.ransack params[:q]
  end
end
