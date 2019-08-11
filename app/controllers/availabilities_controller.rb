# Manage Expert Availabilities
class AvailabilitiesController < ApplicationController
  # Initialize availabilities for Expert's onboarding Schedule
  def new
    @availabilities = current_user.availabilities.new
  end

  # Set New Availabilities
  # Params:
  # - availablities [Hash]: (e.g: {"Monday" => ['9:00','10,00']})
  # rubocop:disable Metrics/AbcSize
  def create
    if params[:availabilities].blank?
      redirect_back(fallback_location: schedule_path)
    else
      params[:availabilities].permit!
      begin
        if current_user.availabilities.present?
          destroy_all_and_create!(params[:availabilities].to_h)
        else
          create_availabilities(params[:availabilities].to_h)
        end
        redirect_to summary_path
      rescue StandardError => e
        flash[:notice] = e.message
        redirect_to schedule_path
      end
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  # expect an hash of availabilities
  # (e.g: {"Monday" => ['9:00','10,00']})
  # Returns availabilities
  # rubocop:disable Metrics/AbcSize
  def create_availabilities(availabilities)
    Time.zone = current_user.timezone.zone_name
    today_str = Date.today.to_s
    availabilities.each do |day, _times|
      availabilities[day].each do |time_key, _start_time|
        next unless current_user.availabilities.find_by(
          day_of_week: day,
          start_time: Time.zone.parse("#{today_str} #{availabilities[day][time_key]}").in_time_zone('UTC')
        ).blank?

        current_user.availabilities.create!(
          day_of_week: day,
          start_time: Time.zone.parse("#{today_str} #{availabilities[day][time_key]}").in_time_zone('UTC')
        )
      end
    end
    current_user.availabilities
  end
  # rubocop:enable Metrics/AbcSize

  # expect an hash of availabilities
  # (e.g: {"Monday" => ['9:00','10,00']})
  def destroy_all_and_create!(availabilities)
    current_user.availabilities.destroy_all
    create_availabilities(availabilities)
  end
end
