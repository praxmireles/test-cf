class AddDefaultCurrencyColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :default_currency, :string, default: 'USD'
  end
end
