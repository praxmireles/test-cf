# frozen_string_literal: true

require 'test_helper'

class MarketplaceableTest < ActiveSupport::TestCase
  include Marketplaceable
  let(:client) { create(:client) }
  let(:expert) { create(:expert) }
  let(:service) { create(:service) }
  let(:appointment) { create(:appointment, expert_id: expert.id, user_id: User.first.id, service_id: service.id) }

  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }
  # def test_process_payment
  #   # Stripe::Charge.stub(:create).with('').and_returns('')
  #   buyer_id = ''
  #   product_id = ''
  #   amount = '1000'
  #   description = '123abc'
  #   stripe_token = stripe_helper.generate_card_token

  #   process_payment(
  #     buyer_id,
  #     product_id,
  #     amount,
  #     description,
  #     stripe_token
  #   )
  # end

  def test_pre_authorize_transaction
    customer = Stripe::Customer.create(email: 'johnny@appleseed.com', source: stripe_helper.generate_card_token)
    client_test = create(:client, stripe_customer_id: customer.id)
    amount = '1000'
    description = '123abc'
    client_id = client_test.id
    appointment_id = appointment.id

    pre_authorize_transaction(
      client_id,
      appointment_id,
      amount,
      description
    )
  end

  def test_settle_pre_authorized_transaction
    customer = Stripe::Customer.create(email: 'johnny@appleseed.com', source: stripe_helper.generate_card_token)
    charge = Stripe::Charge.create(amount: 400, currency: 'usd', customer: customer.id, description: 'Charge')
    create(:payment, charge_id: charge.id, appointment_id: appointment.id, user_id: client.id)
    settle_pre_authorized_transaction(charge.id)
  end

  def test_create_customer
    client_id = client.id
    stripe_token = stripe_helper.generate_card_token
    create_customer(client_id, stripe_token)
  end

  # rubocop:disable Metrics/AbcSize
  def test_transfer_fund
    customer = Stripe::Customer.create(email: 'johnny@appleseed.com', source: stripe_helper.generate_card_token)
    charge = Stripe::Charge.create(amount: 400, currency: 'usd', customer: customer.id, description: 'Charge')
    create(:payment, charge_id: charge.id, appointment_id: appointment.id, user_id: client.id)
    expert.balance.balance_items.create(user_id: client.id, amount: 50, paid: false, appointment_id: appointment.id)

    transfer_fund(expert)
  end
  # rubocop:enable Metrics/AbcSize

  def test_amount_to_cent
    amount_to_cent(appointment.price)
  end

  def test_failed_payout_transaction
    expert.balance.balance_items.create(user_id: client.id, amount: 50, paid: false, appointment_id: appointment.id)
    failed_payout_transaction('RateLimitError', 'test', expert.id, expert.balance.balance_items.first.id, 'Stripe')
  end

  def test_failed_charge_transaction
    failed_charge_transaction('APIConnectionError', 'test message', client.id, appointment.id)
  end
end
