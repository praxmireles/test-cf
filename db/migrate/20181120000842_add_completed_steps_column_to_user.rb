class AddCompletedStepsColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :completed_steps, :string, array: true, default: [].to_yaml
  end
end
