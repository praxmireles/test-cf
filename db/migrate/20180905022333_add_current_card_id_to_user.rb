class AddCurrentCardIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_card_id, :integer
  end
end
