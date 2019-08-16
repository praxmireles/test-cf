class AddDescriptionColumnToSearchHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :description, :text
  end
end
