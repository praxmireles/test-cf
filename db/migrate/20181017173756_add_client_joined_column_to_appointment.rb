class AddClientJoinedColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :client_joined, :boolean, default: false
    add_column :appointments, :expert_joined, :boolean, default: false
  end
end
