# User's Job Functions
class ProfileJobFunctionsController < ApplicationController
  def create
    redirect_to about_path if destroy_all_and_create(
      params[:job_functions],
      params[:skills]
    )
  end

  def destroy
    current_user.profile.job_functions.find(
      params[:profile_job_function_id]
    ).destroy
  end

  private

  def destroy_all_and_create(job_functions, skills)
    destroy_job_functions_and_create(
      job_functions
    ) && destroy_skills_and_create(skills)
  end

  def destroy_job_functions_and_create(job_functions)
    current_user.profile.job_functions.destroy_all
    add_job_function(job_functions)
  end

  def destroy_skills_and_create(skills)
    current_user.profile.skills.destroy_all
    add_skills(skills)
  end

  def add_job_function(job_functions)
    return false unless job_functions
    new_job_functions = []
    job_functions.each do |job_function_id|
      new_job_function = current_user.profile.job_functions.create!(
        job_function_id: job_function_id
      )

      new_job_functions << new_job_function if new_job_function.created_at?
    end
    if new_job_functions.empty?
      false
    else
      true
    end
  end

  def add_skills(skills)
    return false unless skills
    new_skills = []
    skills.each do |skill_id|
      new_skill = current_user.profile.skills.create!(
        skill_id: skill_id
      )

      new_skills << new_skill if new_skill.created_at?
    end
    if new_skills.empty?
      false
    else
      true
    end
  end
end
