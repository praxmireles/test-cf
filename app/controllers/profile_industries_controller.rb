# User Industries
class ProfileIndustriesController < ApplicationController
  def create
    profile_industry = current_user.profile.industries.new(
      profile_industry_params
    )
    redirect_to work_industries_path if profile_industry.save
  end

  def edit
    @work_industries = current_user.profile.industries
                                   .find(params[:profile_industry_id])
  end

  def update
    @work_industry = current_user.profile.industries
                                 .find(params[:profile_industry_id])
    @work_industry.update(profile_industry_params)
    redirect_to work_industries_path
  end

  def destroy
    if current_user.profile.industries
                   .find(params[:profile_industry_id]).destroy
      redirect_to work_industries_path
    else
      false
    end
  end

  private

  def profile_industry_params
    params.require(:profile_industry).permit(
      :industry_id, :profile_id, :years
    )
  end
end
