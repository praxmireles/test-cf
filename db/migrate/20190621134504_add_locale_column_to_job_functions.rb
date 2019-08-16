class AddLocaleColumnToJobFunctions < ActiveRecord::Migration[5.2]
  def change
    add_column :job_functions, :locale, :string
  end
end
