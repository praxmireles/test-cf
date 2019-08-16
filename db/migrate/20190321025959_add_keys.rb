class AddKeys < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key "balance_items", "appointments"
    add_foreign_key "balance_items", "appointments", on_delete: :cascade
  end
end
