class AddSearchHistoryIdColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :search_history, foreign_key: true
  end
end
