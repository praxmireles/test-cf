class AddTimeChangeRequestedColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :time_change_requested, :boolean, default: false
  end
end
