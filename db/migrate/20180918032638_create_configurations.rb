class CreateConfigurations < ActiveRecord::Migration[5.2]
  def change
    create_table :configurations do |t|
      t.float :express_adivce_price
      t.float :mentoring_price
      t.float :coaching_price
      t.float :mentoring_introduction_price
      t.float :coaching_introduction_price
      t.integer :max_day_before_confirmation

      t.timestamps
    end
  end
end
