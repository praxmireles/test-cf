class ChangeStartAndEndColumnOnAvailabilitiesToStartTimeAndEndTime < ActiveRecord::Migration[5.2]
  def change
    rename_column :availabilities, :start, :start_time
    rename_column :availabilities, :end, :end_time
  end
end
