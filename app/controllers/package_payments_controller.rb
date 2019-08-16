class PackagePaymentsController < ApplicationController
  # rubocop:disable Metrics/AbcSize
  def checkout
    @service = Service.find(params[:service_id])
    @expert = Expert.find(params[:expert_id])

    OpenAppointmentPack.transaction do
      @appointment_pack = OpenAppointmentPack.new(
        user_id: current_user.id,
        expert_id: @expert.id,
        description: "Session of #{params[:package_option]} Package",
        name: @service.type,
        service_id: @service.id
      )

      if @appointment_pack.save
        if @appointment_pack.populate_with_appointments(params[:dates_selected])
          @appointment_pack.calculate_price
          @appointment_pack.save
        else
          redirect_back(fallback_location: root_path)
        end
      else
        puts "ERROR: #{appointment_pack.errors}"
        redirect_back(fallback_location: root_path)
      end
    end
  end
  # rubocop:enable Metrics/AbcSize
end
