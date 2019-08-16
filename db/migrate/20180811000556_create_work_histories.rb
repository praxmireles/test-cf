class CreateWorkHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :work_histories do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :company
      t.string :location
      t.datetime :from_date
      t.datetime :to_date
      t.boolean :present
      t.boolean :linkedin_import, default: false

      t.timestamps
    end
  end
end
