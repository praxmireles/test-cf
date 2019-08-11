class CreateFailedPayments < ActiveRecord::Migration[5.2]
  def change
    create_table :failed_payments do |t|
      t.integer :client_id
      t.integer :appointment_id
      t.string :failure_code
      t.timestamps
    end
  end
end
