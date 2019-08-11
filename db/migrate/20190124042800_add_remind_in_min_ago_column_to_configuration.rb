class AddRemindInMinAgoColumnToConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :configurations, :remind_in_min_ago, :integer
  end
end
