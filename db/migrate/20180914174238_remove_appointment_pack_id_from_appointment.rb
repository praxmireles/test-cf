class RemoveAppointmentPackIdFromAppointment < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointments, :appointment_pack_id
  end
end
