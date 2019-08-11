class CreateProfileSeniorityLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_seniority_levels do |t|
      t.references :profile, foreign_key: true
      t.references :seniority_level, foreign_key: true

      t.timestamps
    end
  end
end
