# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'team@mindswithpurpose.com'
  layout 'mailer'
end
