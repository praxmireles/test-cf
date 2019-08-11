class AddPriceColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :price, :float
  end
end
