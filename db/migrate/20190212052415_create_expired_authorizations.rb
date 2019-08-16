class CreateExpiredAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :expired_authorizations do |t|
      t.integer :payment_id
      t.integer :appointment_id
      t.boolean :refund

      t.timestamps
    end
  end
end
