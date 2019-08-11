class AddMessageColumnToFailedPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :failed_payments, :message, :string
  end
end
