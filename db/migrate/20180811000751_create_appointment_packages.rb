class CreateAppointmentPackages < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_packs do |t|
      t.references :user, foreign_key: true
      t.string :type, default: 'OpenAppointmentPack'
      t.integer :expert_id
      t.float :price
      t.text :description
      t.string :name
      t.boolean :ready_for_schedule

      t.timestamps
    end
  end
end
