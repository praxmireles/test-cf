class AddKeysAdditional < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key "invoices", "payments"
    add_foreign_key "invoices", "payments", on_delete: :cascade
  end
end
