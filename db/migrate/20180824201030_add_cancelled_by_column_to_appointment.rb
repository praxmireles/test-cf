class AddCancelledByColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :cancelled_by, :string
  end
end
