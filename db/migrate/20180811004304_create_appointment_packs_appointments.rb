class CreateAppointmentPacksAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_packs_appointments do |t|
      t.references :appointment_pack, foreign_key: true
      t.references :appointment, foreign_key: true

      t.timestamps
    end
  end
end
