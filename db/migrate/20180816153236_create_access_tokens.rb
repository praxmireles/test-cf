class CreateAccessTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :access_tokens do |t|
      t.references :user
      t.string :provider
      t.string :token
      t.datetime :expires_at
      t.boolean :expired

      t.timestamps
    end
  end
end