require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  def setup
    @client = create(:client)
    service = create(:service)
    expert = create(:expert)
    @invoice = create(:invoice)
    @appointment = create(:appointment, start_date: Date.today, service_id: service.id, expert_id: expert.id, user_id: @client.id, stripe_charge_id: '6')
    @payment = create(:payment, appointment: @appointment)
    @date = '13/12/2018'
  end

  def test_completed_enrollment!
    actual = @client.completed_enrollment!
    assert_equal Mail::Message, actual.class
  end

  def test_scheduled_appointments_start_dates
    actual = @client.scheduled_appointments_start_dates(@date)
    assert_equal Array, actual.class
  end

  def test_update_payment
    actual = @client.update_payment(@appointment.id)
    assert_equal Payment, actual.class
  end

  def test_create_invoices
    actual = @client.create_invoices(@appointment.id)
    assert_equal Invoice, actual.class
  end
end
