# Take care of adding services to Expert profile
class ExpertServicesController < ApplicationController
  def create
    services = []
    params[:services_ids].each do |service_id|
      services << current_user.services.find_or_create_by(service_id: service_id.to_i)
    end
    redirect_to languages_path if services.present?
  end

  def destroy
    current_user.services.find(
      params[:service_id]
    ).destroy
  end
end
