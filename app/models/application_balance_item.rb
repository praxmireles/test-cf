class ApplicationBalanceItem < ApplicationRecord
  has_paper_trail

  belongs_to :application_balance
  belongs_to :appointment

  after_save :update_balance_value

  def update_balance_value
    application_balance.calculate_total_amount!
  end

  def mark_as_paid
    update_attributes(paid: true)
  end
end
