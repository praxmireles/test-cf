class AddExpertIdAndSearhHistoryIdColumnToRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :requests, :expert_id, :integer, foreign_key: true
    add_reference :requests, :search_history, foreign_key: true
  end
end
