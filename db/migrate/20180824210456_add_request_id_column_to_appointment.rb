class AddRequestIdColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :request, foreign_key: true
  end
end
