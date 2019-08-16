class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.references :user, foreign_key: true
      t.integer :expert_id
      t.references :payment, foreign_key: true
      t.integer :appointment_id, foreign_key: true
      t.datetime :date
      t.datetime :due_date

      t.timestamps
    end
  end
end
