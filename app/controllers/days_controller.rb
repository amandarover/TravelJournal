# Day class
class DaysController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @days = Day.all
  end

  def new
    @day = Day.new
  end

  def edit
    @day = Day.find(params[:id])
  end

  def create
    @day = Day.new(day_params)

    if @day.save
      redirect_to day_path(@day.id)
    else
      render new_day_path
      logger.info(
        ">>>>>>CONTROLLER: Error to save day with params: #{day_params}"
      )
    end
  end

  def update
    @day = Day.find(params[:id])
    if @day.update(day_params)
      redirect_to day_path(@day.id)
    else
      render edit_day_path
      logger.info(
        ">>>>>>CONTROLLER: Error to update day with params: #{day_params}"
      )
    end
  end

  def show
    @day = Day.find(params[:id])
  end

  def destroy
    @day = Day.find(params[:id])
    # TODO: verify if destroy its ok and don't have and dependencies
    @day.destroy
    redirect_to days_path
  end

  private

  def day_params
    params.require(:day).permit(:date)
  end
end
