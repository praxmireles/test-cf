class AddMessageColumnToFailedPayout < ActiveRecord::Migration[5.2]
  def change
    add_column :failed_payouts, :message, :string
  end
end
