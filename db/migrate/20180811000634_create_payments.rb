class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :user, foreign_key: true
      t.integer :appointment_id
      t.integer :appointment_package_id
      t.float :amount
      t.string :card_last4

      t.timestamps
    end
  end
end
