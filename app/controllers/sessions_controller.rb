# frozen_string_literal: true

# Manages users sessions by setting or destroying session[:user_id]
class SessionsController < ApplicationController
  # Login page
  def new
    redirect_to_onboarding_or_dashboard if current_user
  end

  def new_expert; end

  def new_client; end

  def terms_services_experts; end

  def terms_services_clients; end

  # Logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

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
end
