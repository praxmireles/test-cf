class RemoveReadyForScheduleColumnFromAppointmentPack < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointment_packs, :ready_for_schedule
  end
end
