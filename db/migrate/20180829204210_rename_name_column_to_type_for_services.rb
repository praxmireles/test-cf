class RenameNameColumnToTypeForServices < ActiveRecord::Migration[5.2]
  def change
    rename_column :services, :name, :type
  end
end
