require 'test_helper'
require 'sidekiq/testing'

class SchedulePreparerWorkerTest < ActiveSupport::TestCase
  def test_perform
    Sidekiq::Testing.inline! do
      SchedulePreparerWorker.perform_async
      assert true
    end
  end
end
