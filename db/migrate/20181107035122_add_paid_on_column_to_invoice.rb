class AddPaidOnColumnToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :paid_on, :datetime
  end
end
