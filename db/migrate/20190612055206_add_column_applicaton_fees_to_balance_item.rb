class AddColumnApplicatonFeesToBalanceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :balance_items, :application_fees, :float
  end
end
