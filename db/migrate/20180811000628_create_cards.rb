class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.integer :payment_id
      t.string :stripe_card_uid
      t.string :stripe_card_brand
      t.string :stripe_card_last4
      t.string :stripe_card_exp_month
      t.string :stripe_card_exp_year

      t.timestamps
    end
  end
end
