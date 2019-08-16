# frozen_string_literal: true

require 'json'
# Manages pages and actions related to the client journey on the website
class ClientsController < ApplicationController
  def edit
    @user = current_user
    @contact_information = current_user
                           .contact_information || current_user
                           .build_contact_information
    @billing = current_user.billing || current_user.build_billing
    @positions = current_user.work_histories.new
  end

  def profile; end

  def modal
    @appointment = current_user.appointments.find(params[:appointment_id])
  end

  # Client Dashboard displays
  # - pending_requests: Request that the user submitted that weren't yet
  #     approved or rejected by and expert. With a [cancel] button
  # - scheduled_appointents: When a PendingRequest is approved an
  #     OpenAppointment is converted to ScheduledAppointment. We use that
  #     to display the appointments to users. It has a [Cancel] button on
  #     the view to allow the user to cancel it.
  # - in_progress_appointments: A list of appointment that are currently
  #     in progress or happening now. There's a [Join] button next to it
  #     to allow users to join it.
  # - past_appointments: Is a combination of CompletedAppointments and
  #     appointment that were ScheduledAppointment that were cancelled

  # rubocop:disable Metrics/AbcSize
  def load_appointments
    # TODO: We're better of creating actions that can be called via ajax
    # so that all the appointment are returned asynchroniously
    # this code will need to be updated and moved to AppointmentController

    # Appointment

    return unless current_user
    @appointments = current_user.appointments

    clean_open_appointments = sanatize_open_appointments(current_user.open_appointments)
    @pending_requests = clean_open_appointments.group_by do |d|
      start_date = set_in_timezone(d.start_date, current_user.id)
      start_date.strftime('%A %B %d')
    end
    @in_progress_appointments = current_user
                                .in_progress_appointments.group_by do |d|
      start_date = set_in_timezone(d.start_date, current_user.id)
      start_date.strftime('%A %B %d')
    end

    @scheduled_appointments = current_user.scheduled_appointments
                                          .group_by do |d|
      start_date = set_in_timezone(d.start_date, current_user.id)
      start_date.strftime('%A %B %d')
    end
    @past_appointments = past_appointments.group_by do |d|
      start_date = set_in_timezone(d.start_date, current_user.id)
      start_date.strftime('%A %B %d')
    end

    # Appointment Packs
    @appointment_packs = active_appointment_packs
    @past_appointment_packs = past_appointment_packs
  end

  # rubocop:enable Metrics/AbcSize
  def dashboard
    if current_user
      @scheduled_appointments_dates = current_user.scheduled_appointments_start_dates('%d/%m/%Y')
      load_appointments
      render layout: 'dashboard'
    else
      session[:user_id] = nil
      redirect_to root_path
    end
  end

  def billing
    @user = current_user
    @contact_information = current_user.build_contact_information
    @billing = current_user.billing
    @positions = current_user.work_histories.create
  end

  def invoices
    @invoices = current_user.invoices.all.order('date DESC')
  end

  def welcome
    @user = current_user
  end

  def reload_dashboard
    load_appointments
  end

  def onboarding_update
    puts client_params
    @user = current_user&.update_attributes(client_params)
    redirect_to client_dashboard_path
  end

  def update
    @user = current_user&.update_attributes(client_params)
    redirect_to client_dashboard_path
    # current_user.assign_attributes(client_params)
    # puts client_params
    # utc_difference = params[:client][:timezone_utc_difference]
    # timezone_continent = params[:client][:timezone_continent]
    # timezone_name = params[:client][:timezone_name]
    # @time_zone = Timezone.where(utc_difference: utc_difference,
    #                             continent: timezone_continent,
    #                             name: timezone_name)[0]
    # current_user.timezone_id = @time_zone.id
    # @user = current_user.save(validate: true)
    # @response = current_user.obtain_response
    #
    # respond_to do |format|
    #   format.js {}
    # end
  end

  def experts_search
    if params[:search_history_id]
      @search_history = SearchHistory.find(params[:search_history_id])
      @experts = Expert.find_match(@search_history.to_search_params)
    else
      redirect_to services_path
    end
  end

  def experts_match
    matching_appointment = CompletedAppointment.where(
      'service_id = ? OR introduction = ?',
      Service.find_by_type('ExpressAdvice').id,
      true
    ).order('end_date DESC')
    @appointments = matching_appointment
  end

  def notification
    @notifications = current_user.notifications
  end

  private

  def active_appointment_packs
    current_user.appointment_packs.where(
      'type = ? OR type = ?',
      'ScheduledAppointmentPack',
      'InProgressAppointmentPack'
    )
  end

  def past_appointments
    current_user.appointments.where(
      'type = ? OR type = ? OR type = ?',
      'CancelledAppointment',
      'CompletedAppointment',
      'ClosedAppointment'
    )
  end

  def past_appointment_packs
    current_user.appointment_packs.where(
      'type = ? OR type = ?',
      'CancelledAppointmentPack',
      'CompletedAppointmentPack'
    )
  end

  def client_params
    params.require(:client).permit(
      :first_name, :last_name, :username, :email, :avatar,
      :accepted_privacy_policy, :completed_onboarding, :location, :timezone_id,
      :files
    )
  end
end
