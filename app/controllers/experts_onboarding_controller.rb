# frozen_string_literal: true

# Manages pages and actions related to the experts journey on the website
class ExpertsOnboardingController < ApplicationController
  ONBOARDING_STEPS_NAMES = %w[
    welcome
    general_information
    resume
    services
    languages
    degrees
    top_level_seniority
    work_industries
    positions
    career_highlights
    skills
    about
    calendar
  ].freeze

  def welcome; end

  def general_information
    @user = current_user
    @contact_information = if current_user.contact_information.present?
                             current_user.contact_information
                           else
                             current_user.build_contact_information
                           end
    add_to_completed_steps('welcome')
    set_current_onboarding_step
  end

  def resume
    add_to_completed_steps('general_information') if profile_information_are_present?
    redirect_to last_onboarding_step unless completed_previous_step('general_information')
    @my_resume = current_user.profile
    set_current_onboarding_step
  end

  def services
    add_to_completed_steps('resume') if current_user.profile.resume.present?
    redirect_to last_onboarding_step unless completed_previous_step('resume')
    set_current_onboarding_step
    @services = current_user.services.new
  end

  def languages
    add_to_completed_steps('services') if current_user.services.present?
    redirect_to last_onboarding_step unless completed_previous_step('services')
    set_current_onboarding_step
    @languages = current_user.profile.languages.new
  end

  def degrees
    add_to_completed_steps('languages') if current_user.languages.present?
    redirect_to languages_path unless completed_previous_step('languages')
    set_current_onboarding_step
    @degrees = current_user.education_histories.new
    @my_degrees = current_user.education_histories.all
  end

  # def education_history
  #   add_to_completed_steps('languages') if current_user.languages.present?
  #   redirect_to languages_path unless completed_previous_step('languages')
  # end

  def top_level_seniority
    add_to_completed_steps('degrees') if current_user.education_histories.present?
    redirect_to last_onboarding_step unless completed_previous_step('degrees')
    set_current_onboarding_step
    @seniority_levels = current_user.seniority_levels.new
  end

  def work_industries
    add_to_completed_steps('top_level_seniority') if current_user.seniority_levels.present?
    redirect_to last_onboarding_step unless completed_previous_step('top_level_seniority')
    set_current_onboarding_step
    @work_industry = current_user.profile.industries.new
    @my_works = current_user.profile.industries.all
  end

  def positions
    add_to_completed_steps('work_industries') if current_user.industries.present?
    redirect_to last_onboarding_step unless completed_previous_step('work_industries')
    set_current_onboarding_step
    @positions = current_user.work_histories.new
    @my_positions = current_user.work_histories.all
  end

  def career_highlights
    add_to_completed_steps('positions') if current_user.work_histories.present?
    redirect_to last_onboarding_step unless completed_previous_step('positions')
    set_current_onboarding_step
    @career_highlight = current_user.career_highlights.new
    @my_career_highlights = current_user.career_highlights.all
  end

  def skills
    add_to_completed_steps('career_highlights') if current_user.career_highlights.present?
    redirect_to last_onboarding_step unless completed_previous_step('career_highlights')
    set_current_onboarding_step
    @job_functions = JobFunction.all.order('name ASC')
  end

  def about
    add_to_completed_steps('skills') if current_user.skills.present?
    redirect_to last_onboarding_step unless completed_previous_step('skills')
    @about = current_user.profile
    set_current_onboarding_step
  end

  def schedule
    @availabilities_slots = AvailabilitiesConstant::AVAILABILITIES_SLOTS
    add_to_completed_steps('about') if current_user.profile.about.present?
    redirect_to last_onboarding_step unless completed_previous_step('about')
    set_current_onboarding_step
  end

  def calendar
    @availabilities_slots = AvailabilitiesConstant::AVAILABILITIES_SLOTS_SESSION
    @week_dates = params[:date] || this_week_dates
  end

  def summary
    @availabilities_slots = AvailabilitiesConstant::AVAILABILITIES_SLOTS
    add_to_completed_steps('calendar') if current_user.availabilities.present?
    redirect_to last_onboarding_step unless completed_previous_step('calendar')
    set_current_onboarding_step
  end

  def confirmation
    set_current_onboarding_step
    redirect_to expert_dashboard_path if current_user.active
    return unless current_user.completed_onboarding == false
    current_user.completed_enrollment!
  end

  # def seniority_level; end

  private

  def this_week_dates(strftime = '%A, %b %e')
    today = Date.today
    @days_from_this_week = (
      today.at_beginning_of_week..today.at_end_of_week
    ).map
    return days_from_this_week unless strftime
    @days_from_this_week.each do |date|
      date.strftime(strftime)
    end
  end

  def last_onboarding_step
    current_user.current_onboarding_step
  end

  def profile_information_are_present?
    if current_user.contact_information.present? &&
       current_user.first_name &&
       current_user.last_name &&
       current_user.avatar &&
       current_user.location &&
       current_user.timezone_id
      true
    else
      false
    end
  end

  def add_to_completed_steps(onboarding_step)
    return if current_user.completed_steps.include? onboarding_step
    current_user.completed_steps << onboarding_step
    current_user.save(validate: false)
  end

  def completed_previous_step(previous_step)
    if current_user.completed_steps.include? previous_step
      true
    else
      false
    end
  end

  def set_current_onboarding_step
    current_user.current_onboarding_step = {
      action: params[:action],
      controller: params[:controller]
    }
    current_user.save(validate: false)
  end
end
