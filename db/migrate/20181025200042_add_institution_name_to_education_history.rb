class AddInstitutionNameToEducationHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :education_histories, :institution_name, :string
  end
end
