class AddAppointmentPackIdToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :appointment_pack_id, :integer, foreign_key: true
  end
end
