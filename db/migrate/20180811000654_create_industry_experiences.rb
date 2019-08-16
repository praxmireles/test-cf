class CreateIndustryExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :industry_experiences do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.integer :experience_in_year

      t.timestamps
    end
  end
end
