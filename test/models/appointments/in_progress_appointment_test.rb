# frozen_string_literal: true

require 'test_helper'

class InProgressAppointmentTest < ActiveSupport::TestCase
  def setup
    @expert = create(:expert)
    @client = create(:client)
    @search_history = create(:search_history, client: @client)
    @service = create(:service)
    @request = create(
      :request,
      search_history_id: @search_history.id,
      client: @client,
      expert: @expert
    )
    @appointment_pack = create(
      :appointment_pack,
      user: @client,
      expert: @expert,
      service: @service
    )
    @appointment = create(:in_progress_appointment, request_id: @request.id, client: @client, expert: @expert, search_history_id: @search_history.id, service: @service)
    @appointment_pack.appointments << @appointment
    @appointment_pack.save
  end

  def test_complete!
    @appointment.complete!
    assert_equal 'CompletedAppointment', Appointment.find(@appointment.id).type
  end
end
