# Manages Admin Session
class AdminSessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @admin_user = AdminUser.new
    render layout: false
  end

  def create
    admin = AdminUser.find_by_email(params[:admin_user][:email])

    session[:admin_id] = admin.id if admin&.authenticate(params[:admin_user][:password])
    redirect_to admin_root_path
  end

  def destroy
    session[:admin_id] = nil
    redirect_to admin_login_path
  end
end
