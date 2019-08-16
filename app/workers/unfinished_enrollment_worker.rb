require 'sidekiq-scheduler'

# Worker that Verify that notification are sent if the expert leaves enrollement
class UnfinishedEnrollmentWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'appointments', retry: false

  def perform
    time_ago = Configuration.try(:first).try(:expert_enrollment_timeout).try(:ago) || 1.hour.ago
    experts = Expert.where('finished_onboarding = ? && created_at > ?', false, time_ago)
    experts.each do |expert|
      notify_user(
        :expert,
        action: :unfinished_enrollment,
        expert_id: expert.id
      )
    end
  end
end
