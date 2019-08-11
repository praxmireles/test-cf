class AddPayoutServiceToFailedPayout < ActiveRecord::Migration[5.2]
  def change
    add_column :failed_payouts, :payout_service, :string
  end
end
