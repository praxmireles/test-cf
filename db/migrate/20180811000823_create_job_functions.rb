class CreateJobFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :job_functions do |t|
      t.string :name

      t.timestamps
    end
  end
end
