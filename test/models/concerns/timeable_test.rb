require 'test_helper'

class TimeableTest < ActiveSupport::TestCase
  let(:expert) { create(:expert) }
  let(:user) { create(:user) }
  let(:availability) { create(:availability, user_id: user.id, start_time: '22:00', day_of_week: 'Monday') }

  def test_next_7_days
    expert.next_7_days
  end

  def test_day_of_week
    availability.day_of_week
  end
end
