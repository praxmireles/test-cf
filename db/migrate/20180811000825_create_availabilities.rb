class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.references :user, foreign_key: true
      t.string :day_of_week
      t.string :start
      t.string :end

      t.timestamps
    end
  end
end
