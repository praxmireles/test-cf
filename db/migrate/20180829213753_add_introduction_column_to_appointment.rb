class AddIntroductionColumnToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :introduction, :boolean, default: false
  end
end
