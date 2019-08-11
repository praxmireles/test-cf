class AddIndustriesColumnToSearchHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :industry, :string
  end
end
