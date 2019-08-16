class CreateAppointmentSuggests < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_suggests do |t|
      t.references :appointment, foreign_key: true
      t.references :user, foreign_key: true
      t.datetime :start_date
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end
