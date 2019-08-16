class AddFilesExpertAndClient < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :files, :string
  end
end
