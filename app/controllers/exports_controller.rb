class ExportsController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.xls {
        filename = "User-#{Time.now.strftime("%Y%m%d%H%M%S")}.xls"
        send_data(@users.to_a.to_xls,
          type: "text/xls; charset=utf-8; header=present",
          filename: filename)
      }
    end
  end
end
