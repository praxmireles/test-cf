# Expert's Career Highlight
class CareerHighlightsController < ApplicationController
  def create
    career_highlight = current_user.career_highlights.new(
      career_highlight_params
    )

    if career_highlight.save
      redirect_to career_highlights_path
      reorganize_highest_highlights(career_highlight.id)
    else
      render status: 500
    end
  end

  def edit
    @career_highlights = current_user.career_highlights
                                     .find(params[:career_highlight_id])
  end

  def update
    @career_highlight = current_user.career_highlights
                                    .find(params[:career_highlight_id])

    @career_highlight.update!(career_highlight_params)
    redirect_to career_highlights_path
  end

  def destroy
    if current_user.career_highlights
                   .find(params[:career_highlight_id]).destroy
      redirect_to career_highlights_path
    end
  end

  private

  def career_highlight_params
    params.require(:career_highlight).permit(:name, :description, :date)
  end

  def reorganize_highest_highlights(career_highlight_id)
    current_user.career_highlights.each do |career_highlight|
      if career_highlight.id == career_highlight_id
        unless career_highlight.highest
          career_highlight.update_attributes(
            highest: true
          )
        end
      else
        unless career_highlight.highest == false
          career_highlight.update_attributes(
            highest: false
          )
        end
      end
    end
  end
end
