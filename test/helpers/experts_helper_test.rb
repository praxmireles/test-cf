require 'test_helper'

class ExpertsHelperTest < ActiveSupport::TestCase
  include ExpertsHelper
  let(:service) { create(:service) }
  let(:expert) { create(:expert) }
  let(:client) { create(:client) }
  let(:appointment) { create(:appointment, start_date: Date.today, service_id: service.id, user_id: client.id) }
  def test_appointment_class
    appointment_class(appointment.type)
  end

  def test_appointment_types_ordered_array
    assert %w[
      InProgressAppointment
      ScheduledAppointment
      CompletedAppointment
      CancelledAppointment
      ClosedAppointment
    ], appointment_types_ordered_array
  end
end
