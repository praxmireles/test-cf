class AddPayoutMethodToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :payout_method, :string
  end
end
