require 'test_helper'
require 'sidekiq/testing'

class AppointmentInProgressWorkerTest < ActiveSupport::TestCase
  include Opentokable

  def setup
    Sidekiq::Testing.fake!
    client = create(:client)
    @scheduled_appointment = create(:scheduled_appointment, user_id: client.id)
  end

  def test_perform
    Sidekiq::Testing.inline! do
      AppointmentInProgressWorker.perform_async(@scheduled_appointment.id)
      assert true
    end
  end
end
