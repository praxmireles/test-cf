class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.string :name
      t.integer :duration_in_min
      t.float :price

      t.timestamps
    end
  end
end
