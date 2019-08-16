class CreateTimezones < ActiveRecord::Migration[5.2]
  def change
    create_table :timezones do |t|
      t.string :name
      t.integer :utc_difference
      t.string :continent

      t.timestamps
    end
  end
end
