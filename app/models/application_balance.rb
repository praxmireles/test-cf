class ApplicationBalance < ApplicationRecord
  has_paper_trail
  has_many :application_balance_items

  def calculate_total_amount!
    self.total_amount = application_balance_items.where(paid: false).sum(:amount)
    save
  end
end
