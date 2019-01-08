class MainController < ApplicationController
  def search
    @users = User.ransack(name_or_email_cont: params[:q]).result(distinct: true)
      .paginate(page: params[:page], per_page: 15)
    respond_to do |format|
      format.html
      format.json do
        @users = @users.limit(5)
      end
    end
  end
end
