class AddContactTimeColumnsToContactInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :contact_informations, :mobile_contact_time, :string
    add_column :contact_informations, :phone_contact_time, :string
  end
end
