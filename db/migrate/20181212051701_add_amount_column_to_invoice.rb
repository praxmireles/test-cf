class AddAmountColumnToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :amount, :float
  end
end
