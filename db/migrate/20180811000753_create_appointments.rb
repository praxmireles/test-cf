class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key: true
      t.string :type, default: 'OpenAppointment'
      t.integer :expert_id
      t.integer :service_id
      t.integer :first_available
      t.string :video_session_uid
      t.string :video_session_token
      t.string :cancel_reason
      t.string :description
      t.string :stripe_charge_uid
      t.string :subject
      t.datetime :cancelled_date
      t.boolean :cancelled
      t.integer :duration_in_min
      t.integer :time_spent_in_min
      t.boolean :offline

      t.timestamps
    end
  end
end
