# Mailer for Expert
class ExpertMailer < ApplicationMailer
  default from: 'team@mindswithpurpose.com'
  layout 'mailer'

  def unfinished_enrollment(expert_id)
    @expert = Expert.find(expert_id)
    mail(
      to: @expert.email,
      subject: 'Mindswithpurpose - Finish Your Enrollment'
    )
  end

  def finished_enrollment(expert_id)
    @expert = Expert.find(expert_id)
    mail(
      to: @expert.email,
      subject: "Mindswithpurpose - You've Completed Your Enrollment"
    )
  end

  def account_approved(expert_id)
    @expert = Expert.find(expert_id)
    mail(
      to: @expert.email,
      subject: 'Mindswithpurpose - Your Account was Approved'
    )
  end

  def account_rejected(expert_id)
    @expert = Expert.find(expert_id)
    mail(
      to: @expert.email,
      subject: 'Mindswithpurpose - Sorry..'
    )
  end

  def appointment_notice(expert_id)
    @expert = Expert.find(expert_id)
    mail(
      to: @expert.email,
      subject: 'Mindswithpurpose - Your appointment with one member of our team'
    )
  end
end
