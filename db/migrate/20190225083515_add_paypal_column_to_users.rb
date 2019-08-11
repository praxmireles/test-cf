class AddPaypalColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :paypal_email, :string
    add_column :users, :payout_method, :string
  end
end
