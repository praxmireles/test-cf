class AddClosedOnAndCloseToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :close_on, :datetime
    add_column :appointments, :close, :boolean
  end
end
