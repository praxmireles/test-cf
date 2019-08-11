class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :type, default: 'NewNotification'
      t.references :user, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
