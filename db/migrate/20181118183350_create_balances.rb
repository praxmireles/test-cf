class CreateBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :balances do |t|
      t.references :user, foreign_key: true
      t.float :total_amount, default: 0.0

      t.timestamps
    end
  end
end
