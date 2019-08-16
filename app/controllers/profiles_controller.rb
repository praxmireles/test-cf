# Manage Profile for Expert
class ProfilesController < ApplicationController
  def update
    profile = current_user.profile
    if params[:profile]
      if profile.update_attributes(profile_params)
        if params[:profile][:resume]
          redirect_to experts_onboarding_services_path
        else
          redirect_to schedule_path
        end
      else
        redirect_back
      end
    else
      redirect_to experts_onboarding_services_path
    end
  end

  def detroy
    current_user.profile.update_attribute(resume: nil)
  end

  private

  def profile_params
    params.require(:profile).permit(:resume, :about)
  end
end
