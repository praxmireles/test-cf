class AddLocaleColumnToCoachingType < ActiveRecord::Migration[5.2]
  def change
    add_column :coaching_types, :locale, :string
  end
end
