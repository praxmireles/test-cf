require 'sidekiq-scheduler'

# Worker that schedule Reminder that a session will start 15min before
# the session starts
class UpcomingAppointmentWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'appointments', retry: false

  def perform(appointment_id)
    appointment = ScheduledAppointment.find_by(id: appointment_id)
    return unless appointment.present?

    AppointmentMailer.appointment_will_start(
      appointment.client.id, appointment_id
    ).deliver
    AppointmentMailer.appointment_will_start(
      appointment.expert.id, appointment_id
    ).deliver
  end
end
