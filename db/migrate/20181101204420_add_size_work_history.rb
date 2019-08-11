class AddSizeWorkHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :work_histories, :size, :string
    add_column :work_histories, :company_url, :string
  end
end
