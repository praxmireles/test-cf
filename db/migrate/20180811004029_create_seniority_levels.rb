class CreateSeniorityLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :seniority_levels do |t|
      t.string :name
      t.string :short_name
      t.string :rank

      t.timestamps
    end
  end
end
