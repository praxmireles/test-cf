# User's Skill
class ProfileSkillsController < ApplicationController
  def create
    skill = current_user.profile.skills.new(
      skill_id: params[:skill_id]
    )

    if skill.save
      render json: { skill: @skill }, status: 200
    else
      render status: 500
    end
  end

  def destroy
    current_user.profile.skills.find(
      params[:skill_id]
    ).destroy
  end
end
