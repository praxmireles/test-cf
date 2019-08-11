class ChangeFailedPayoutColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :failed_payouts, :stripe_failure_code, :failure_code
  end
end
