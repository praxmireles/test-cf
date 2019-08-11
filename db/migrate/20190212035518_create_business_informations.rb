class CreateBusinessInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :business_informations do |t|
      t.integer :user_id
      t.string :business_name
      t.string :corporation_number
      t.string :gst_hst_number
      t.string :country

      t.timestamps
    end
  end
end
