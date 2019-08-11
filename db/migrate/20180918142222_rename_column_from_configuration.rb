class RenameColumnFromConfiguration < ActiveRecord::Migration[5.2]
  def change
    rename_column :configurations, :express_adivce_price, :express_advice_price
    rename_column :configurations, :max_day_before_confirmation, :auto_cancelation_in_days
  end
end
