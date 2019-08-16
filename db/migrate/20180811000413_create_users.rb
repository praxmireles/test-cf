class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :username
      t.boolean :active, default: false
      t.string :email
      t.string :job
      t.string :company
      t.string :facebook_url
      t.string :google_url
      t.string :linkedin_url
      t.string :avatar
      t.string :provider
      t.string :stripe_customer_id
      t.float :hourly_rate
      t.boolean :accepted_privacy_policy, default: false
      t.datetime :accepted_policy_on
      t.string :facebook_uid
      t.string :linkedin_uid
      t.boolean :completed_onboarding, default: false
      t.string :location
      t.integer :timezone_id
      t.boolean :coach, default: false
      t.string :last_sign_in_ip
      t.string :current_sign_in_ip
      t.datetime :last_sign_in_at
      t.integer :sign_in_count

      t.timestamps
    end
  end
end
