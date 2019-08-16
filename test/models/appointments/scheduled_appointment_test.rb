# frozen_string_literal: true

class ScheduledAppointmentTest < ActiveSupport::TestCase
  def setup
    @expert = create(:expert)
    @client = create(:client)
    @search_history = create(:search_history, client: @client)
    @request = create(
      :request,
      search_history_id: @search_history.id,
      client: @client,
      expert: @expert
    )
    @appointment = create(
      :scheduled_appointment,
      request_id: @request.id,
      client: @client,
      expert: @expert,
      search_history_id: @search_history.id,
      service: Service.first
    )

    Opentokable.stubs(:create_session)
               .returns(token: '12aaf', session_id: '123aaa')

    ScheduledAppointment.any_instance.stubs(:create_session).with(1, 2)
                        .returns(token: '12aaf', session_id: '123aaa')
    ScheduledAppointment.any_instance.stubs(:create_session)
                        .returns(token: '12aaf', session_id: '123aaa')
  end

  def test_start!
    @appointment.start!
    assert_equal 'InProgressAppointment',
                 Appointment.find(@appointment.id).type
  end

  def test_cancel_by_client!
    @appointment.cancel_by_client!
    assert_equal 'CancelledAppointment',
                 Appointment.find(@appointment.id).type
  end

  def test_cancel_by_expert!
    @appointment.cancel_by_expert!
    assert_equal 'CancelledAppointment',
                 Appointment.find(@appointment.id).type
  end
end
