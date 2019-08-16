class BalanceItem < ApplicationRecord
  has_paper_trail

  belongs_to :balance
  belongs_to :user
  belongs_to :appointment

  after_save :update_balance_value

  def update_balance_value
    balance.calculate_total_amount!
  end

  def mark_as_paid
    update_attributes(paid: true)
  end

  def fees
    application_fees || 0.2
  end

  def due_to_expert
    amount * (1 - fees) || appointment.due_to_expert
  end

  def due_to_application
    amount * fees || appointment.due_to_application
  end
end
