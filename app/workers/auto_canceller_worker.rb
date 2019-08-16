require 'sidekiq-scheduler'

# Worker that cancel late PendingRequest
class AutoCancellerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'appointments', retry: false

  def perform
    Appointment.cancel_late_pending_request
  end
end
