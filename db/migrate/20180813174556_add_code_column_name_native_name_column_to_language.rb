class AddCodeColumnNameNativeNameColumnToLanguage < ActiveRecord::Migration[5.2]
  def change
    add_column :languages, :code, :string
    add_column :languages, :native_name, :string
  end
end
