# frozen_string_literal: true

# Manages pages and actions related to the experts journey on the website

require 'active_support/core_ext'
# Expert Controller
class ExpertsController < ApplicationController
  def edit; end

  def modal
    @appointment = current_user.appointments.find(params[:appointment_id])
  end

  # Expert Dashboard displays
  # - pending_requests: Request that the user submitted that weren't yet
  #     approved or rejected by and expert. With a [approve] or [reject]
  #     button
  # - scheduled_appointents: When a PendingRequest is approved an
  #     OpenAppointment is converted to ScheduledAppointment. We use that
  #     to display the appointments to users. It has a [Cancel] button on
  #     the view to allow the user to cancel it.
  # - in_progress_appointments: A list of appointment that are currently
  #     in progress or happening now. There's a [Join] button next to it
  #     to allow users to join it.
  # - past_appointments: Is a combination of CompletedAppointments and
  #     appointment that were ScheduledAppointment that were cancelled
  def load_appointments
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

    @appointments = current_user.appointments

    # Appointment Packs
    @appointment_packs = active_appointment_packs
    @past_appointment_packs = past_appointment_packs
  end

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

  def reload_dashboard
    load_appointments
  end

  def profile
    @expert = Expert.find(params[:id])
    return unless params[:search_history_id]
    @search_history = SearchHistory.find(
      params[:search_history_id]
    )
  end

  def balance
    @balance = current_user.balance
    @unpaid_balance_items = @balance.balance_items_ready.select { |x| x if x.paid == false }
    @paid_balance_items = @balance.balance_items_ready.select { |x| x if x.paid == true }
  end

  def update
    redirect_to resume_path if current_user&.update_attributes(expert_params)
  end

  def availabilities
    date = params[:date]
    expert = Expert.find(params[:id])
    times = expert.availabilities_for(date).map do |t|
      if current_user
        set_in_timezone(t.in_time_zone('UTC'), current_user.id).strftime('%H:%M')
      else
        t.in_time_zone(Time.zone)
      end
    end

    @times = times.sort.map do |t|
      Time.parse(t).strftime('%l:%M %p')
    end
  end

  def reload_client_dashboard; end

  def list_available_date_by_month
    @expert = Expert.find(params[:id])
    if @expert.type == 'Expert'
      from = Date.parse(params[:year] + '-' + params[:month] + '-01')
      to = from.end_of_month
      if @expert
        @available_schedules_days = @expert.this_month_schedule(from, to).map do |x|
          set_in_timezone(x, @expert.id).strftime('%d/%m/%Y') if Date.parse(x) > Date.yesterday
        end
        @available_schedules_days = @available_schedules_days.uniq
      end
      respond_to do |format|
        format.json { render json: @available_schedules_days, status: 200 }
      end
    else
      respond_to  status: 200
    end
  end

  # Expert booking on a given date
  #
  # Params
  # - date [String]: format "%d/%m/%Y"
  #    example: '11/19/2018'
  #
  # Returns an array of time:
  #  eg: ["8:00", "12:00"]
  def availabilities_booking_for_list
    @expert = Expert.find(params[:id])
    respond_to do |format|
      format.json { render json: @expert.availabilities_booking_for(params[:date]), status: 200 }
    end
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

  def expert_params
    params.require(:expert).permit(
      :first_name, :last_name, :username, :email, :job, :company, :avatar,
      :accepted_privacy_policy, :completed_onboarding, :location, :timezone_id, :files,
      :payout_method, :accepted_privacy_policy, :paypal_email, :completed_onboarding, :location, :timezone_id,
      contact_information_attributes: %i[primary_phone secondary_phone primary_mobile
                                         secondary_mobile mobile_contact_time phone_contact_time]
    )
  end
end
