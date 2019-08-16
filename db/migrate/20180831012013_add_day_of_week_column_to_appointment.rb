class AddDayOfWeekColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :day_of_week, :string
  end
end
