class CreateContactInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_informations do |t|
      t.references :user, foreign_key: true
      t.string :primary_phone
      t.string :secondary_phone
      t.string :primary_mobile
      t.string :secondary_mobile

      t.timestamps
    end
  end
end
