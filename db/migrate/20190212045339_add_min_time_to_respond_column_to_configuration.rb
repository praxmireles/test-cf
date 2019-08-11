class AddMinTimeToRespondColumnToConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :configurations, :min_time_to_respond_in_hours, :integer, default: '4'
  end
end
