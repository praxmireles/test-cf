class RemoveColumnPaymentIdFromCard < ActiveRecord::Migration[5.2]
  def change
    remove_column :cards, :payment_id
  end
end
