class Balance < ApplicationRecord
  has_paper_trail

  belongs_to :expert
  belongs_to :appointments
  has_many :balance_items, dependent: :delete_all

  def calculate_total_amount!
    self.total_amount = balance_items.where(paid: false).sum(:amount)
    save
  end

  # Balance items should be refleced to expert 48 hours after a session
  def balance_items_ready
    balance_items.where('created_at < ?', 48.hours.ago).order('created_at DESC')
  end
end
