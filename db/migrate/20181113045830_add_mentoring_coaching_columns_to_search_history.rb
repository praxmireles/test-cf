class AddMentoringCoachingColumnsToSearchHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :achieve_experiences, :text
    add_column :search_histories, :why, :text
  end
end
