class AddServiceIdColumnToAppointmentPack < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointment_packs, :service, foreign_key: true
  end
end
