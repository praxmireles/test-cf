class AddIsBusinessTrueColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_business, :boolean, default: false
  end
end
