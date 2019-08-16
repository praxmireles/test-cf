# User's Education History
class EducationHistoriesController < ApplicationController
  def create
    education_histories = current_user.education_histories.new(
      education_history_params
    )
    redirect_to degrees_path if education_histories.save
  end

  def edit
    @degrees = current_user.education_histories
                           .find(params[:education_history_id])
  end

  def update
    @degree = current_user.education_histories
                          .find(params[:education_history_id])
    @degree.update(education_history_params)
    redirect_to degrees_path
  end

  def destroy
    if current_user.education_histories
                   .find(params[:education_history_id]).destroy
      redirect_to degrees_path
    else
      false
    end
  end

  private

  def education_history_params
    params.require(:education_history).permit(
      :degree, :field_of_study, :from_date, :to_date, :present,
      :institution_name, :id
    )
  end
end
