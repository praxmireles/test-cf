class AddLocaleColumnToSkills < ActiveRecord::Migration[5.2]
  def change
    add_column :skills, :locale, :string
  end
end
