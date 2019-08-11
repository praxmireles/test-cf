class CreateBalanceItems < ActiveRecord::Migration[5.2]
  def change
    create_table :balance_items do |t|
      t.references :balance, foreign_key: true
      t.references :user, foreign_key: true
      t.float :amount, default: 0.0
      t.boolean :paid, default: :false
      t.references :appointment, foreign_key: true
      t.string :description
      
      t.timestamps
    end
  end
end
