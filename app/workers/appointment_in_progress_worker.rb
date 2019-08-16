require 'sidekiq-scheduler'

# Worker that change ScheduledAppointment to InProgressAppointment
class AppointmentInProgressWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'appointments', retry: false

  def perform(appointment_id)
    appointment = ScheduledAppointment.find_by(id: appointment_id)
    return unless appointment.present?
    appointment.start!
  end
end
