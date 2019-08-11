class AddColumnApplicatonFeesToApplicationBalanceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :application_balance_items, :application_fees, :float
  end
end
