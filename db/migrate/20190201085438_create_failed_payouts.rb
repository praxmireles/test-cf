class CreateFailedPayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :failed_payouts do |t|

      t.integer :expert_id
      t.integer :balance_id
      t.float :current_balance_amount
      t.integer :last_balance_item_id
      t.string :stripe_failure_code

      t.timestamps
    end
  end
end
