class AddLegalNameColumnToBillingTable < ActiveRecord::Migration[5.2]
  def change
    add_column :billings, :legal_name, :string
  end
end
