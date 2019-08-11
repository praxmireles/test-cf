# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery
  before_action :set_paper_trail_whodunnit
  protect_from_forgery with: :exception

  before_action :set_locale

  def set_locale
    I18n.locale = if current_user
                    current_user.locale
                  else
                    I18n.locale = if params[:locale].present?
                                    params[:locale] || I18n.default_locale
                                  else
                                    cookies[:locale] || I18n.default_locale
                                  end
                  end
  end

  def set_in_timezone(time, user_id)
    user = User.find(user_id)
    if user.timezone.present?
      time.in_time_zone(user.timezone.zone_name)
    else
      time.in_time_zone(Time.zone)
    end
  end

  # rubocop:disable Metrics/PerceivedComplexity
  def redirect_to_onboarding_or_dashboard
    if current_user.type == 'Client'
      if current_user.timezone.present?
        redirect_to client_dashboard_path
      else
        redirect_to client_welcome_path
      end
    elsif current_user.type == 'Expert'
      if current_user.completed_onboarding?
        redirect_to expert_dashboard_path
      else
        go_to_current_onboarding_step
      end
    end
  end
  # rubocop:enable Metrics/PerceivedComplexity

  # rubocop:disable Metrics/AbcSize
  def go_to_current_onboarding_step
    if current_user.current_onboarding_step.present?
      if current_user.current_onboarding_step[:action].present? &&
         current_user.current_onboarding_step[:controller].present?

        redirect_to action: current_user.current_onboarding_step[:action],
                    controller: current_user
                      .current_onboarding_step[:controller]
      else
        redirect_to expert_onboarding_path
      end
    else
      redirect_to expert_onboarding_path
    end
  end
  # rubocop:enable Metrics/AbcSize

  # Clean Appointments and Request if an OpenAppointment exists
  # with a Request that is not of type `PendingRequest`.
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/PerceivedComplexity
  def sanatize_open_appointments(open_appointments)
    open_appointment_to_fix = []
    sanitized_array = open_appointments.select do |x|
      if x.request.present?
        if x.request.type == 'PendingRequest'
          true
        else
          open_appointment_to_fix << x
          false
        end
      else
        open_appointment_to_fix << x
        false
      end
    end
    open_appointment_to_fix.each do |x|
      if x.request.present?
        if x.request.type == 'AcceptedRequest'
          x.schedule_appointment!
        else
          # Delete both appointment and request
          x.request.destroy
          x.destroy
        end
        # else
        # DO NOTHING
      end
    end
    sanitized_array.sort_by(&:start_date)
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/PerceivedComplexity

  private

  def signed_in?
    session[:user_id]
  end
  helper_method :signed_in?

  def current_user=(user)
    session[:user_id] = user.id
  end

  def current_advisor
    current_user if current_user.type == 'Expert'
  end

  def current_user
    return unless signed_in?
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user
end
