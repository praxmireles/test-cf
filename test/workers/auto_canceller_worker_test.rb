require 'test_helper'
require 'sidekiq/testing'

class AutoCancellerWorkerTest < ActiveSupport::TestCase
  def test_perform
    Sidekiq::Testing.inline! do
      AutoCancellerWorker.perform_async
      assert true
    end
  end
end
