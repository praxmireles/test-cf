class AddColumnToSearchHistory < ActiveRecord::Migration[5.2]
  def change
    remove_column :search_histories, :query
    add_column :search_histories, :first_available, :boolean
    add_column :search_histories, :service, :string
    add_column :search_histories, :functions, :string
    add_column :search_histories, :skills, :string
    add_column :search_histories, :seniority_level, :string
    add_column :search_histories, :coaching_type, :string
  end
end
