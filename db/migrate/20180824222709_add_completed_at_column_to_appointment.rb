class AddCompletedAtColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :completed_on, :datetime
    add_column :appointments, :scheduled_on, :datetime
    rename_column :appointments, :cancelled_date, :cancelled_on
  end
end
