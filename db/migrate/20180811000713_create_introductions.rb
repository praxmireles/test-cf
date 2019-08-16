class CreateIntroductions < ActiveRecord::Migration[5.2]
  def change
    create_table :introductions do |t|
      t.references :service, foreign_key: true
      t.string :name
      t.integer :duration_in_min
      t.float :price

      t.timestamps
    end
  end
end
