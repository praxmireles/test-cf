# frozen_string_literal: true

require 'test_helper'
require 'ostruct'

class PaymentTest < ActiveSupport::TestCase
  def setup
    user = User.first || create(:user)
    expert = Expert.first || create(:expert)
    appointment = create(:appointment, start_date: Time.now, service_id: Service.first.id, user_id: user.id, expert_id: expert.id)
    appointment_pack = create(:appointment_pack, service_id: Service.first.id)
    @payment = create(:payment, user_id: user.id, appointment_id: appointment.id, appointment_pack_id: appointment_pack.id)
    # @payment.appointment_id = appointment.id
    # @payment.appointment_pack_id = appointment_pack.id
  end

  # def test_generate_invoice
  #   invoice = @payment.generate_invoice
  #   assert_respond_to(invoice, :expert_id)
  #   assert_respond_to(invoice, :payment_id)
  #   assert_respond_to(invoice, :appointment_id)
  #   assert_respond_to(invoice, :due_date)
  #   assert_respond_to(invoice, :paid_on)
  #   assert_not_nil(invoice.id, nil)
  # end
end
