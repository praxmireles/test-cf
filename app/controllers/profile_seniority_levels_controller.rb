# User's Seniority Level
class ProfileSeniorityLevelsController < ApplicationController
  def create
    saved_all = nil
    SeniorityLevel.transaction do
      params[:seniority_level_ids].each do |seniority_level_id|
        seniority_level = current_user.profile.seniority_levels.find_or_create_by(
          seniority_level_id: seniority_level_id
        )
        seniority_level.save
      end
      saved_all = true
    end

    if saved_all
      redirect_to work_industries_path
    else
      redirect_back
    end
  end

  def destroy
    current_user.profile.seniority_levels.find(
      params[:seniority_level_id]
    ).destroy
  end
end
