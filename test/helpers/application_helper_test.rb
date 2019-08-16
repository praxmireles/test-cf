require 'test_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper
  let(:ser) { create(:service) }
  let(:user) { create(:user) }
  let(:exp) { create(:expert) }
  let(:client) { create(:client) }
  let(:appointment) { create(:appointment, start_date: Date.today, service_id: ser.id, user_id: client.id) }
  def setup
    @appointment = client.in_progress_appointments.create(expert_id: exp.id, service_id: ser.id, start_date: Date.today)
  end

  def test_format_date_long
    actual = format_date_long(appointment.created_at)
    assert_equal String, actual.class
  end

  def test_set_in_timezone
    actual = set_in_timezone(@appointment.start_date, user.id)
    assert_equal ActiveSupport::TimeWithZone, actual.class
  end
end
