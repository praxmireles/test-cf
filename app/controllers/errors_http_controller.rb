# Erros Http
class ErrorsHttpController < ApplicationController
  before_action :skip_authorization, only: [:show]
  # layout "http_code"
  def show
    @http_code = status_code
    respond_to do |format|
      format.html { render status: @http_code }
      format.xml  { head @http_code }
      format.any  { head @http_code }
    end
  end

  protected

  def status_code
    params[:http_code] || 500
  end
end
