class ChangePaymentColumnsFromPayment < ActiveRecord::Migration[5.2]
  def change
    rename_column :payments, :appointment_package_id, :appointment_pack_id
    add_column :payments, :brand, :string
    add_column :payments, :exp_month, :string
    add_column :payments, :exp_year, :string
  end
end