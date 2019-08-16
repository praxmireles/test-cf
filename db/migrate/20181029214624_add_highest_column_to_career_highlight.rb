class AddHighestColumnToCareerHighlight < ActiveRecord::Migration[5.2]
  def change
    add_column :career_highlights, :highest, :boolean, default: false
  end
end
