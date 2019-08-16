class AddLocaleColumnToIndustries < ActiveRecord::Migration[5.2]
  def change
    add_column :industries, :locale, :string
  end
end
