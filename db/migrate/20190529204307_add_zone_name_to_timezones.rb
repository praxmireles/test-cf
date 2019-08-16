class AddZoneNameToTimezones < ActiveRecord::Migration[5.2]
  def up
    add_column :timezones, :zone_name, :string
  end

  def down
    remove_column :timezones, :zone_name
  end
end