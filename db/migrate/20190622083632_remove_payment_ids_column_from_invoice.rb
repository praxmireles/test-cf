class RemovePaymentIdsColumnFromInvoice < ActiveRecord::Migration[5.2]
  def change
    remove_column :invoices, :payment_ids
  end
end
