# frozen_string_literal: true

# Handle communication with the Opentok service
module Marketplaceable
  extend ActiveSupport::Concern
  included do
    # Charge card immediately
    def process_payment(
      client,
      customer,
      product_id,
      amount,
      description
    )
      @charge = Stripe::Charge.create(
        amount: amount.to_i,
        currency: 'usd',
        description: description,
        customer: customer.id,
        source: customer.sources.first.id,
        receipt_email: client.email
      )
    rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
      failed_charge_transaction('RateLimitError', e.messsage, client.id, product_id)
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
      failed_charge_transaction('InvalidRequestError', e.message, client.id, product_id)
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)failed_charge_transaction(e.http_status, client.id, appointment_id)
      failed_charge_transaction('AuthenticationError', e.message, client.id, product_id)
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
      failed_charge_transaction('APIConnectionError', e.message, client.id, product_id)
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      failed_charge_transaction('StripeError', e.message, client.id, product_id)
    rescue StandardError => e
      # Something else happened, completely unrelated to Stripe
      failed_charge_transaction('UnexpectedError', e.message, client.id, product_id)
    end

    # Client pay for the totality of an appointment package upfront
    # MWP keep the amount as a retainer until a session is delivered by the
    # Expert. The amount of each independent session is released  to the expert
    # at the end of each session.
    def process_appointment_pack_transaction(
      client_id,
      appointment_pack_id,
      amount,
      description
    )
      appointment_pack = AppointmentPack.find(appointment_pack_id)

      client = Client.find(client_id)
      customer = Stripe::Customer.retrieve(client.stripe_customer_id)

      process_payment(
        client,
        customer,
        appointment_pack.id,
        amount,
        description
      )
    end

    # Auth and capture
    #
    # A pre-authorization is like a full authorization, but instead of
    # pulling funds from the customer's credit card, it merely places a hold
    # on the money. While no transaction has taken place and the funds are
    # still in the customer's account, unmoved, the customer won't be able
    # to access it until the pre-auth hold expires.
    # Usually, a pre-auth will last for approximately 5-7 days.
    def pre_authorize_transaction(
      client_id,
      appointment_id,
      amount,
      description
    )
      client = Client.find(client_id)
      customer = Stripe::Customer.retrieve(client.stripe_customer_id)

      begin
        @charge = Stripe::Charge.create(
          amount: amount.to_i,
          currency: 'usd',
          description: description,
          customer: customer.id,
          source: customer.sources.first.id,
          capture: false,
          receipt_email: client.email
        )
      rescue Stripe::RateLimitError => e
        # Too many requests made to the API too quickly
        failed_charge_transaction('RateLimitError', e.messsage, client.id, appointment_id)
      rescue Stripe::InvalidRequestError => e
        # Invalid parameters were supplied to Stripe's API
        failed_charge_transaction('InvalidRequestError', e.message, client.id, appointment_id)
      rescue Stripe::AuthenticationError => e
        # Authentication with Stripe's API failed
        # (maybe you changed API keys recently)
        failed_charge_transaction('AuthenticationError', e.message, client.id, appointment_id)
      rescue Stripe::APIConnectionError => e
        # Network communication with Stripe failed
        failed_charge_transaction('APIConnectionError', e.message, client.id, appointment_id)
      rescue Stripe::StripeError => e
        # Display a very generic error to the user, and maybe send
        # yourself an email
        failed_charge_transaction('StripeError', e.message, client.id, appointment_id)
      rescue StandardError => e
        # Something else happened, completely unrelated to Stripe
        failed_charge_transaction('UnexpectedError', e.message, client.id, appointment_id)
      end
    end

    def settle_pre_authorized_transaction(charge_id)
      charge = Stripe::Charge.retrieve(charge_id)
      payment = Payment.find_by_charge_id(charge_id)
      invoice = Invoice.find_by_payment_id(payment.id)
      appointment = payment.appointment
      client = payment.user

      if charge.capture
        payment.mark_as_paid
        invoice.mark_as_paid
      else
        false
      end
    rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
      failed_charge_transaction('RateLimitError', e.messsage, client.id, appointment.id)
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
      failed_charge_transaction('InvalidRequestError', e.message, client.id, appointment.id)
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
      failed_charge_transaction('AuthenticationError', e.message, client.id, appointment.id)
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
      failed_charge_transaction('APIConnectionError', e.message, client.id, appointment.id)
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      failed_charge_transaction('StripeError', e.message, client.id, appointment.id)
    rescue StandardError => e
      # Something else happened, completely unrelated to Stripe
      failed_charge_transaction('UnexpectedError', e.message, client.id, appointment.id)
    end

    def create_customer(client_id, stripe_token)
      client = Client.find(client_id)
      customer = Stripe::Customer.create(
        description: "Customer for #{client.email}",
        source: stripe_token
      )
      client.update_attributes(stripe_customer_id: customer.id)
    end

    def transfer_fund(expert)
      expert.balance.balance_items.where(paid: false).each do |balance_item|
        transfer_each_fund(expert.id, balance_item.id)
      end
    end

    def paypal_payout(expert)
      return unless expert.paypal_email
      expert.balance.balance_items.where(paid: false).each do |balance_item|
        process_paypal_payout(balance_item.appointment.id)
      end
    end

    def transfer_each_fund(expert_id, balance_item_id)
      expert = Expert.find(expert_id)
      balance_item = BalanceItem.find(balance_item_id)

      @charge = Stripe::Transfer.create(
        amount: amount_to_cent(expert.balance.total_amount),
        currency: 'cad',
        destination: expert.stripe_account_id,
        source_transaction: balance_item.appointment.payment.charge_id
      )
      balance_item.mark_as_paid
      balance_item.update_attributes(stripe_payout_id: @charge.id, payout_service: 'Stripe') if @charge
      PaymentMailer.sent_payout(expert.id, balance_item.appointment.payment.id)
    rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
      failed_payout_transaction('RateLimitError', e.messsage, expert.id, balance_item.id, 'Stripe')
    rescue Stripe::InvalidRequestError => e
      # Invalid parameters were supplied to Stripe's API
      failed_payout_transaction('InvalidRequestError', e.message, expert.id, balance_item.id, 'Stripe')
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
      failed_payout_transaction('AuthenticationError', e.message, expert.id, balance_item.id, 'Stripe')
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
      failed_payout_transaction('APIConnectionError', e.message, expert.id, balance_item.id, 'Stripe')
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
      failed_payout_transaction('StripeError', e.message, expert.id, balance_item.id, 'Stripe')
    rescue StandardError => e
      # Something else happened, completely unrelated to Stripe
      failed_payout_transaction('UnexpectedError', e.message, expert.id, balance_item.id, 'Stripe')
    end

    def change_external_account(expert_id)
      expert = Expert.find(expert_id)
      account = Stripe::Account.retrieve(expert.stripe_account_id.to_s)
      account.external_accounts
    end
  end

  def amount_to_cent(amount)
    (amount * 100).to_i
  end

  def failed_payout_transaction(error_code, message, expert_id, balance_item_id, service)
    expert = Expert.find(expert_id)
    balance_item = BalanceItem.find(balance_item_id)

    FailedPayout.create(
      failure_code: error_code,
      expert_id: expert.id,
      last_balance_item_id: balance_item.id,
      current_balance_amount: expert.balance.total_amount,
      balance_id: balance_item.balance_id,
      message: message,
      payout_service: service
    )
  end

  def failed_charge_transaction(error_code, message, client_id, appointment_id)
    client = Client.find(client_id)
    appointment = Appointment.find(appointment_id)

    FailedPayment.create(
      failure_code: error_code,
      client_id: client.id,
      appointment_id: appointment.id,
      message: message
    )
  end

  def process_paypal_payout(appointment_id)
    appointment = Appointment.find(appointment_id)
    amount = appointment.price
    balance_item = appointment.balance_item
    expert = appointment.expert
    payout_init(amount, expert.paypal_email, balance_item.id)
    begin
      @payout_batch = @payout.create
      if @payout_batch.present?
        balance_item.mark_as_paid
        balance_item.update_attributes(
          paypal_id: @payout_batch.batch_header.payout_batch_id,
          payout_service: 'Paypal'
        )
      end
    rescue StandardError => err
      failed_payout_transaction('PaypalError', err.message, expert.id, balance_item.id, 'Paypal')
    end
  end

  def payout_init(amount, paypal_email, balance_item_id)
    @payout = PayPal::SDK::REST::Payout.new(
      sender_batch_header: {
        sender_batch_id: SecureRandom.hex(8),
        email_subject: 'You have a Payout!'
      },
      items: [{
        recipient_type: 'EMAIL',
        amount: {
          value: amount,
          currency: 'USD'
        },
        note: 'Thanks for your business',
        receiver: paypal_email,
        sender_item_id: "#{SecureRandom.hex(3)}_#{balance_item_id}"
      }]
    )
  end
end
