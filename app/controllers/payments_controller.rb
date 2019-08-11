# frozen_string_literal: true

# Manages pages and actions related to payments
class PaymentsController < ApplicationController
  include Marketplaceable
  # rubocop:disable Metrics/AbcSize

  # Process a pre-authorize_transaction
  def create
    search_history = SearchHistory.find(params[:search_history_id])
    stripe_token = params[:stripeToken]
    appointment =  search_history.appointments.first

    @charge = create_customer_and_charge(appointment, search_history, stripe_token)

    if appointment.present? && @charge
      # rubocop:disable Lint/UselessAssignment
      payment = appointment.client.payments.create!(
        user_id: appointment.client.id,
        appointment_id: appointment.id,
        appointment_pack_id: nil,
        amount: @charge.amount,
        brand: @charge.source.brand,
        card_last4: @charge.source.last4,
        exp_month: @charge.source.exp_month,
        exp_year: @charge.source.exp_year,
        paid: false,
        charge_id: @charge.id
      )
      # rubocop:enable Lint/UselessAssignment

      appointment.activate_request(@charge.id)

      # TODO: reactivate this
      # appointment.notify_user(:payment,
      #                         action: :pre_authorized_appointment,
      #                         payment_id: payment.id)

      if current_user.contact_information.present?
        redirect_to client_dashboard_path
      else
        redirect_to client_payment_contact_information_path(search_history_id: params[:search_history_id])
      end

    elsif appointment.blank?
      flash.now[:alert] = 'Appointment has been not created please try again'
      redirect_to client_payment_contact_information_path(search_history_id: params[:search_history_id])
    else
      redirect_back(fallback_location: client_payment_card_path(search_history_id: params[:search_history_id]))
    end
  end
  # rubocop:enable Metrics/AbcSize

  # rubocop:disable Metrics/AbcSize
  def pay_package
    if params[:appointment_pack_id].present?
      appointment_pack = AppointmentPack.find(params[:appointment_pack_id])
      @charge = pay_appointment_pack(appointment_pack.id)

      if @charge
        appointment_pack.client.payments.create!(
          user_id: appointment_pack.client.id,
          appointment_pack_id: appointment_pack.id,
          amount: appointment_pack.price,
          brand: @charge.source.brand,
          card_last4: @charge.source.last4,
          exp_month: @charge.source.exp_month,
          exp_year: @charge.source.exp_year,
          paid: true,
          charge_id: @charge.id
        )

        # Send the client the full invoice
        appointment_pack.client.create_appointment_pack_invoices(appointment_pack.id)

        appointment_pack.appointments.each do |appointment|
          appointment.update_attributes(type: 'ScheduledAppointment')
          # Send clicent an invoice divided for each appointment
          appointment.expert.create_balance_item(appointment.id, is_from_pack: true)
          appointment.request.try(:activate!)
        end

        appointment_pack.update_attributes(
          type: 'ScheduledAppointmentPack',
          stripe_charge_id: @charge.id
        )

        redirect_to root_path
      else
        redirect_back(fallback_location: root_path)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end
  # rubocop:enable   Metrics/AbcSize

  private

  def create_customer_and_charge(appointment, search_history, stripe_token)
    return  unless appointment.present?
    create_customer(appointment.client.id, stripe_token) unless appointment.client.stripe_customer_id.present?
    advance_authorize_transaction(search_history.id, stripe_token)
  end

  # TODO: Use this method in create
  def handle_payment_with_params!
    if params[:search_history_id].present?
      search_history = SearchHistory.find(params[:search_history_id])
      stripe_token = params[:stripeToken]
      advance_authorize_transaction(search_history.id, stripe_token)
    elsif params[:appointment_pack_id].present?
      appointment_pack = AppointmentPack.find(params[:appointment_pack_id])
      pay_appointment_pack(appointment_pack.id)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def advance_authorize_transaction(search_history_id, stripe_token)
    search_history = SearchHistory.find(search_history_id)
    appointment = search_history.appointments.first
    amount = amount_to_cent(appointment.price)
    description = "Client: #{appointment.client.id} | Expert: #{appointment.expert.id} | \
    Session #{appointment.id}"

    create_customer(appointment.client. id, stripe_token) unless appointment.client.stripe_customer_id.present?

    pre_authorize_transaction(
      appointment.client.id,
      appointment.id,
      amount,
      description
    )
  end
  # rubocop:enable Metrics/AbcSize

  def pay_appointment_pack(appointment_pack_id)
    appointment_pack = AppointmentPack.find(appointment_pack_id)
    description = "Client: #{appointment_pack.client.id} | Expert: #{appointment_pack.expert.id} | \
    Package #{appointment_pack.id}"

    process_appointment_pack_transaction(
      appointment_pack.client.id,
      appointment_pack.id,
      appointment_pack.price,
      description
    )
  end
end
