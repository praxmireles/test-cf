# frozen_string_literal: true

module ExpertsOnboardingHelper
  def profile_language_exists?(language_id)
    # TODO: change to use .where | not sure this is working properly
    current_user.profile.languages.pluck(:language_id).include? language_id
  end

  def seniority_level_exists?(seniority_level_id)
    current_user.seniority_levels.where(seniority_level_id: seniority_level_id).present?
  end

  def job_function_exist?(job_function_id)
    # TODO: change to use .where | not sure this is working properly
    current_user.profile.job_functions.pluck(
      :job_function_id
    ).include? job_function_id
  end

  def skill_exist?(skill_id)
    # TODO: change to use .where | not sure this is working properly
    current_user.profile.skills.pluck(:skill_id).include? skill_id
  end
end
