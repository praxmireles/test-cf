# Manage the programing of sessions

class AppointmentPacksController < ApplicationController
  # Create an appointment_pack with multiple sheduled appointments
  #
  # Params:
  # - appointment [Hash]
  # -- client_id
  # -- expert_id
  # -- description
  # -- name
  # -- stat_dates [Array]
  # -- service_id
  # Returns
  def create
    render status: 406 unless verify_appointment_count(params[:start_dates])
    appointment_pack = AppointmentPack.schedule_appointments(
      appointment_params.merge(start_dates: params[:start_dates])
    )
    if appointment_pack
    # render json: { appointment_pack: appointment_pack, status: 200 },
    # status: 200
    else
      render status: 500
    end
  end

  # rubocop:disable Metrics/AbcSize
  def new
    @availabilities_slots = AvailabilitiesConstant::AVAILABILITIES_SLOTS
    @expert = Expert.find(params[:expert_id])
    @month = params[:month] || Date::MONTHNAMES[Date.today.month]
    @year = params[:year] || Time.now.year
    @week_dates = params[:date] || this_week_dates

    @dates_selected = []
    @package_option = params[:package_option] || 5
    @services = [
      Service.find_by_type('Mentoring'),
      Service.find_by_type('Coaching')
    ]
    @service = @services.first
    @appointment_pack = AppointmentPack.new

    # clear dates_selected from session
    session[:dates_selected] = nil
  end
  # rubocop:enable Metrics/AbcSize

  def calendar; end

  def summary
    @expert = Expert.find(params[:expert_id])
    @service = Service.find(params[:service_id])

    @package_option = params[:package_option]
    @appointment_pack = AppointmentPack.new
    @dates_selected = params[:dates_selected] || session[:dates_selected] || []
  end

  def add
    puts params
    @appointment_from = Appointment.find(params[:appointment_id])
    @appointment_to = Appointment.new
    @appointment_to = @appointment_from.dup
    @appointment_to.start_date = params[:start_date]
    @appointment_to.save
    @response = @appointment_to.obtain_response
    respond_to do |format|
      format.json { render json: @response, status: :ok }
    end
  end

  # Cancel an appointment_pack along with all scheduled appointments
  # associatedd to it
  def destroy
    appointment_pack = current_user.appointment_packs.find(
      params[:appointment_pack_id]
    )
    appointment_pack.cancel!
  end

  # Display an Appointment Packs with the list of the appointments
  def show
    @appointment_pack = current_user.appointment_packs.find(
      params[:appointment_pack_id]
    )

    @appointments = @appointment_pack.appointments
  end

  # rubocop:disable Metrics/AbcSize
  def next_week
    last_date = params[:end_of_current_week].to_date
    next_week = last_date.next_week

    @week_dates = (
      next_week.at_beginning_of_week..next_week.at_end_of_week
    ).to_a
    @availabilities_slots = AvailabilitiesConstant::AVAILABILITIES_SLOTS

    @expert = Expert.find(params[:expert_id])
    @month = Date::MONTHNAMES[next_week.at_beginning_of_week.month]
    @year = params[:year] || next_week.at_beginning_of_week.year
    # TODO: Pass the date selected to the next page of the calendar
    # @dates_selected = params[:date_selected] || []
    # @package_option = params[:package_option] || 5
    @appointment_pack = AppointmentPack.new

    # Preserve dates_selected in sessions
    session[:dates_selected] = params[:dates_selected]
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def previous_week
    first_day = params[:beginning_of_current_week].to_date
    prev_week = first_day.prev_week

    @week_dates = (
      prev_week.at_beginning_of_week..prev_week.at_end_of_week
    ).to_a

    @availabilities_slots = AvailabilitiesConstant::AVAILABILITIES_SLOTS
    @expert = Expert.find(params[:expert_id])
    @month = Date::MONTHNAMES[prev_week.at_beginning_of_week.month]
    @year = params[:year] || prev_week.at_beginning_of_week.year
    # TODO: Pass the date selected to the next previous of the calendar
    # @dates_selected = params[:date_selected] || []
    # @package_option = params[:package_option] || 5
    @appointment_pack = AppointmentPack.new

    # Preserve dates_selected in sessions
    session[:dates_selected] = params[:dates_selected]
  end
  # rubocop:enable Metrics/AbcSize

  private

  def this_week_dates(strftime = '%A, %b %e')
    today = Date.today
    @days_from_this_week = (
      today.at_beginning_of_week..today.at_end_of_week
    ).map
    return @days_from_this_week unless strftime
    @days_from_this_week.each do |date|
      date.strftime(strftime)
    end
  end

  # Session an only be booked by session fo 5 or 8
  def verify_appointments_count(start_dates)
    if start_dates.count == 5
      true
    elsif start_dates.count == 8
      false
    else
      false
    end
  end

  def appointment_params
    params.require(:appointment).permit(
      :client_id, :expert_id, :description, :name
    )
  end
end
