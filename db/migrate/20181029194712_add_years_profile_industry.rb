class AddYearsProfileIndustry < ActiveRecord::Migration[5.2]
  def change
    add_column :profile_industries, :years, :integer
  end
end
