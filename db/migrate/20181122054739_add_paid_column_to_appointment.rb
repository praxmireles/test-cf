class AddPaidColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :paid, :boolean
    add_column :appointments, :pre_authorized, :boolean
    add_column :appointments, :stripe_charge_id, :string
  end
end
