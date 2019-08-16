class AddColumnToBalanceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :balance_items, :payout_service, :string
    add_column :balance_items, :stripe_payout_id, :string
    add_column :balance_items, :paypal_id, :string
  end
end
