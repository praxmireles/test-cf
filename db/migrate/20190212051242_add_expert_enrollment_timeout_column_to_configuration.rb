class AddExpertEnrollmentTimeoutColumnToConfiguration < ActiveRecord::Migration[5.2]
  def change
    add_column :configurations, :expert_enrollment_timeout, :integer
  end
end
