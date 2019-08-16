class AddColumnsToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :wildcard, :string
    add_column :notifications, :prefix, :string
    add_column :notifications, :suffix, :string
    add_column :notifications, :locale, :string
  end
end
