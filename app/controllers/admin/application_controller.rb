# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
      return unless AdminUser.any?
      redirect_to admin_login_path unless current_admin
    end

    def current_admin=(admin)
      session[:admin_id] = admin.id
    end

    def admin_signed_in?
      session[:admin_id]
    end
    helper_method :admin_signed_in?

    def current_admin
      return unless admin_signed_in?
      @current_admin ||= AdminUser.find_by(id: session[:admin_id])
    end
    helper_method :current_admin

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
