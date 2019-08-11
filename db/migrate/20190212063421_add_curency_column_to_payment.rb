class AddCurencyColumnToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :currency, :string, default: 'USD'
  end
end
