class ChangeTimesToBeDateInAvailability < ActiveRecord::Migration[5.2]
  def up
    remove_column :availabilities, :start_time
    add_column :availabilities, :start_time, :time

    remove_column :availabilities, :end_time
    add_column :availabilities, :end_time, :time
  end

  def down
    remove_column :availabilities, :start_time
    add_column :availabilities, :start_time, :string

    remove_column :availabilities, :end_time
    add_column :availabilities, :end_time, :string
  end
end