class CreateJoinTableUsersApplicants < ActiveRecord::Migration[5.2]
  def change
    create_join_table :users, :applicants do |t|
      t.index [:user_id, :applicant_id]
      t.index [:applicant_id, :user_id]
    end
  end
end
