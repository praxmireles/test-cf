class CreateEducationHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :education_histories do |t|
      t.references :user, foreign_key: true
      t.string :degree
      t.string :field_of_study
      t.datetime :from_date
      t.datetime :to_date
      t.boolean :present
      t.boolean :linkedin_import, default: false

      t.timestamps
    end
  end
end
