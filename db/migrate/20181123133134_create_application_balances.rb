class CreateApplicationBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :application_balances do |t|
      t.float :total_amount

      t.timestamps
    end
  end
end
