class AddLocaleColumnToSeniorityLevels < ActiveRecord::Migration[5.2]
  def change
    add_column :seniority_levels, :locale, :string
  end
end
