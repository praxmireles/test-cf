# frozen_string_literal: true

# Manages pages and actions for appointments once a request is approved
class AppointmentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :destroy
  # A page for creating an appointment

  # rubocop:disable Metrics/AbcSize
  def new
    if params[:search_history_id]
      @search_history = SearchHistory.find(params[:search_history_id])
      @first_available = false
      @expert = Expert.find(params[:expert_id])
      if @expert
        @available_schedules_days = @expert.availabilities_today_to_next_week(
          '%d/%m/%Y'
        ).map { |x| set_in_timezone(x, current_user.id).strftime('%d/%m/%Y') }
        @appointment = Appointment.new(
          search_history_id: @search_history.id,
          user_id: current_user.id
        )
      else
        redirect_to clients_experts_search_path(
          search_history_id: params[:search_history_id]
        )
      end
    else
      redirect_to services_path
    end
  end

  def create
    search_history = SearchHistory.find(params[:search_history_id])
    expert = Expert.find(params[:expert_id])
    service = Service.find_by(type: search_history.service)

    request = current_user.open_requests.create!(
      expert_id: expert.id,
      search_history_id: search_history.id
    )

    appointment = Appointment.new(
      appointment_params.merge(
        service_id: service.id,
        expert_id: expert.id,
        user_id: current_user.id,
        first_available: search_history.first_available,
        search_history_id: search_history.id,
        introduction: true,
        request_id: request.id
      )
    )
    if appointment.save
      # redirect_to new_client_billings_path(
      #   search_history_id: params[:search_history_id]
      # )
      if current_user.billing
        redirect_to client_payment_card_path(search_history_id: params[:search_history_id])
      else
        redirect_to client_payment_billing_path(search_history_id: params[:search_history_id])
      end
    else
      render :new
    end
  end

  # rubocop:enable Metrics/AbcSize

  # A page showing the detail of a specfic appointment
  def show
    @appointment = Appointment.first
    # @appointment = current_user.appointments.find(params[:appointment_id])
  end

  # A page for editing the appointment
  def edit
    @appointment = current_user.appointments.find(params[:appointment_id])
  end

  # Update the Status of an Appointment
  #
  # Params
  # - appointment_id : id of the appointment
  # - command : options are 'schedule', 'start' or 'complete'
  # - time_spent_in_min : determine how long the conference call was
  def update
    appointment = current_user.appointments.find(params[:appointment_id])
    case params[:command]
    when 'schedule'
      appointment.schedule!
    when 'start'
      appointment.start!
    when 'complete'
      appointment.complete!(params[:time_spent_in_min])
      # else
      # TO DO: handle error
    end
    redirect_to root_path
  end

  # Cancel an Appointment
  #
  # Params:
  # - appointment_id : id of the appointment
  # - user_type : options are 'client' or 'expert'.
  def destroy
    appointment = current_user.appointments.find(params[:appointment_id])
    if current_user.type == 'expert'
      appointment.cancel_by_expert!
    else
      appointment.cancel_by_client!
    end

    redirect_to root_path
  end

  # Process the payment for a given appointment using StripeService
  #
  # Params:
  # - appointment_id : id of the appointment
  def checkout
    @appointment = current_user.appointments.find(params[:appointment_id])

    # TO DO: Process the credit card of the user here
  end

  def expert_availability
    @expert = Expert.find(params[:id])
    @available_schedules_days = @expert.availabilities_today_to_next_week(
      '%d/%m/%Y'
    ).map { |x| set_in_timezone(x, current_user.id).strftime('%d/%m/%Y') }
    respond_to do |format|
      format.json { render json: @available_schedules_days, status: :ok }
    end
  end

  # rubocop:disable Metrics/AbcSize
  def active_appointments
    @appointments = []
    current_user.appointments.each do |a|
      @appointments.push(
        'appointment_id' => a.id,
        'start_date' => set_in_timezone(a.start_date, current_user.id),
        'start_time' => set_in_timezone(a.start_date, current_user.id).to_formatted_s(:time),
        'end_date' => set_in_timezone(a.end_date, current_user.id),
        'end_time' => set_in_timezone(a.end_date, current_user.id).to_formatted_s(:time),
        'duration_in_min' => a.duration_in_min,
        'description' => a.search_history.description,
        'client_name' => a.client.first_name + ' ' + a.client.last_name,
        'expert_name' => a.expert.first_name + ' ' + a.expert.last_name,
        'service' => a.search_history.service,
        'user_type' => current_user.type
      )
    end
    respond_to do |format|
      format.json { render json: @appointments, status: :ok }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def appointment_suggests_save
    @appointment_suggests = AppointmentSuggest.where(
      appointment_id: params[:appointment_id],
      user_id: params[:user_id]
    ).destroy_all

    @appointment_suggest = AppointmentSuggest.new(
      appointment_id: params[:appointment_id],
      user_id: params[:user_id],
      start_date:  params[:start_date]
    )
    @appointment_suggest.save
    @response = @appointment_suggest.obtain_response

    respond_to do |format|
      format.json { render json: @response, status: :ok }
    end
  end

  # rubocop:disable Metrics/AbcSize
  def appointment_suggests_accept
    AppointmentSuggest.update(
      params[:appointment_suggests_id],
      accepted: true
    ).obtain_response
    @appointment_suggest = AppointmentSuggest.find(params[:appointment_suggests_id])
    @appointment = Appointment.find(@appointment_suggest.appointment_id)
    @appointment.update_attributes(
      completed_on: nil,
      start_date: @appointment_suggest.start_date,
      end_date:  @appointment_suggest.start_date + @appointment.duration_in_min / 60,
      type: 'ScheduledAppointment',
      cancelled_on: nil,
      cancelled: false,
      cancelled_by: nil
    )
    @appointment.obtain_response

    @appointment_suggests = AppointmentSuggest.where(
      appointment_id: @appointment_suggest.appointment_id
    ).destroy_all

    respond_to do |format|
      format.json { render json: @response, status: :ok }
    end
  end
  # rubocop:enable Metrics/AbcSize

  private

  def appointment_params
    params.require(:open_appointment).permit(
      :subject, :description, :start_date
    )
  end
end
