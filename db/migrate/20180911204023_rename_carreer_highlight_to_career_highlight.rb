class RenameCarreerHighlightToCareerHighlight < ActiveRecord::Migration[5.2]
  def change
    rename_table :carreer_highlights, :career_highlights
  end
end
