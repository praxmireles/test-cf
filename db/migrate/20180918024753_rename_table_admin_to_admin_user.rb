class RenameTableAdminToAdminUser < ActiveRecord::Migration[5.2]
  def change
    rename_table :admins, :admin_users
  end
end
