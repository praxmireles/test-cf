require 'sidekiq-scheduler'

# Worker that schedule AppointmentInProgess to be scheduled for change at
# a the appointment start_time
class SchedulePreparerWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'appointments', retry: false

  def perform
    Appointment.prepare_today_scheduled_appointment
  end
end
