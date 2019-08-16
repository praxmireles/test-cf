class AddCurrentOnboardingStepToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_onboarding_step, :string
  end
end
