# Mailer for Client
class ClientMailer < ApplicationMailer
  default from: 'team@mindswithpurpose.com'
  layout 'mailer'

  def find_an_expert(client_id)
    @client = Client.find(client_id)
    mail(
      to: @client.email,
      subject: 'Mindswithpurpose - Finish Your Enrollment'
    )
  end

  def welcome(client_id)
    @client = Client.find(client_id)
    mail(
      to: @client.email,
      subject: "Mindswithpurpose - You've Finished Your Enrollment"
    )
  end

  def service_reminder(client_id)
    @client = Client.find(client_id)
    mail(to: @client.email, subject: 'Mindswithpurpose - Hire an Expert')
  end
end
