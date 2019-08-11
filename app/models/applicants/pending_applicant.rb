class PendingApplicant < Applicant
  def approve!
    user = User.find(user_id)
    user.update_attributes(active: true)
    update_attributes(type: 'ApprovedApplicant')
  end

  def reject!
    update_attributes(type: 'RejectedApplicant')
  end
end
