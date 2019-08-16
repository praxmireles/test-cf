require 'sidekiq-scheduler'

# handle request with no response within x hours
class CheckPendingRequestsWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'appointments', retry: false

  def perform
    time_ago = Configuration.first.min_time_to_respond_in_hours.try(:hours).try(:ago) || 4.hours.ago
    appointments = Appointment.where(
      'type=? and start_date > ?', 'ScheduledAppointment', time_ago
    )
    appointments.each do |appointment|
      expert_matches = appointment.search_history.find_match(first_available: true)
      expert_matches.each do |expert|
        unless expert.id == appointment.expert_id
          AppointmentMailer.first_available_request(expert.id, appointment.id).deliver
        end
      end
    end
  end
end
