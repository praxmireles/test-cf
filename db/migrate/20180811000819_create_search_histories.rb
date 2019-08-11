class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|
      t.references :user, foreign_key: true
      t.string :query

      t.timestamps
    end
  end
end
