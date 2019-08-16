class RenameColumnOnSearchHistory < ActiveRecord::Migration[5.2]
  def change
    rename_column :search_histories, :why, :what_changes
  end
end
