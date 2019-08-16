class AddActionToNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :action, :string
  end
end
