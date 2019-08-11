class RenameSeniorityLevelColumnOnSearchHistory < ActiveRecord::Migration[5.2]
  def change
    rename_column :search_histories, :seniority_level, :seniority_levels
  end
end
