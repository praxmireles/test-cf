class CreateProfileJobFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :profile_job_functions do |t|
      t.references :profile, foreign_key: true
      t.references :job_function, foreign_key: true

      t.timestamps
    end
  end
end
