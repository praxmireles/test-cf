class AddConfirmationMaxDaysColumnToConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :configurations, :confirmation_max_days, :integer, default: 2
  end
end
