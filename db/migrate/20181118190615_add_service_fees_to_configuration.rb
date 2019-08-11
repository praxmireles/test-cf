class AddServiceFeesToConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :configurations, :service_fees, :float, default: 0.2
  end
end
