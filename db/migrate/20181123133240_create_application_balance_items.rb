class CreateApplicationBalanceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :application_balance_items do |t|
      t.integer :application_balance_id
      t.float :amount
      t.boolean :paid
      t.integer :appointment_id
      t.string :description

      t.timestamps
    end
  end
end
