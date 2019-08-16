# Pendingg Expert waiting to be approved
class PendingApplicantsController < ApplicationController
  def update
    applicant = PendingApplicant.find(params[:id])

    case params[:answer]
    when 'approve'
      applicant.approve!
    when 'reject'
      applicant.reject!
    end

    redirect_to admin_pending_applicants_path
  end
end
