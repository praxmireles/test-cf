class CreateCarreerHighlights < ActiveRecord::Migration[5.2]
  def change
    create_table :carreer_highlights do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :description
      t.datetime :date

      t.timestamps
    end
  end
end
