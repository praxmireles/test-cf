class AddTypeColumnToRating < ActiveRecord::Migration[5.2]
  def change
    add_column :ratings, :type, :string
  end
end
