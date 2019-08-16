class AddAppointmentPackIdColumnToInvoices < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :appointment_pack_id, :integer
    add_column :invoices, :payment_ids, :string
  end
end
