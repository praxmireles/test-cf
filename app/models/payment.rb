# frozen_string_literal: true

# == Schema Information
#
# Table name: payments
#
#  id                  :bigint(8)        not null, primary key
#  user_id             :bigint(8)
#  appointment_id      :integer
#  appointment_pack_id :integer
#  amount              :float
#  card_last4          :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  charge_id           :string
#  brand               :string
#  exp_month           :string
#  exp_year            :string
#

class Payment < ApplicationRecord
  include Notificable
  has_paper_trail

  belongs_to :user
  belongs_to :appointment
  has_one :invoice, dependent: :delete

  def mark_as_paid
    update_attributes(paid: true)

    notify_user(:payment,
                action: :paid_appointment,
                payment_id: id)
  end

  def generate_invoice
    appointment.client.invoices.create(
      user_id: appointment.user_id,
      expert_id: appointment.expert_id,
      appointment_id: appointment.id,
      payment_id: id,
      date: Time.now,
      due_date: Time.now,
      amount: amount
    )
  end

  def amount_to_cents
    amount / 100
  end
end
