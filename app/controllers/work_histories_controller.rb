# Manages Expert's Work History
class WorkHistoriesController < ApplicationController
  def create
    work_histories = current_user.work_histories.new(work_history_params)
    redirect_to positions_path if work_histories.save
  end

  def edit
    @positions = current_user.work_histories
                             .find(params[:work_history_id])
  end

  def update
    @position = current_user.work_histories
                            .find(params[:work_history_id])
    @position.update(work_history_params)
    redirect_to positions_path
  end

  def destroy
    if current_user.work_histories.find(params[:work_history_id]).destroy
      redirect_to positions_path
    else
      false
    end
  end

  private

  def work_history_params
    params.require(:work_history).permit(
      :title, :company, :location, :from_date, :to_date, :present,
      :size, :company_url
    )
  end
end
