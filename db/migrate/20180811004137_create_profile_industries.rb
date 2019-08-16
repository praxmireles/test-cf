class CreateProfileIndustries < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_industries do |t|
      t.references :profile, foreign_key: true
      t.references :industry, foreign_key: true

      t.timestamps
    end
  end
end
