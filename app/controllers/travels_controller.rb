# Class of Travels
class TravelsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @travels = Travel.all
  end

  def new
    @travel = Travel.new
  end

  def edit
    @travel = Travel.find(params[:id])
  end

  def create
    @travel = Travel.new(travel_params)

    if @travel.save
      redirect_to travel_path(@travel.id)
    else
      render new_travel_path
      logger.info(
        ">>>>>>CONTROLLER: Error to save travel with params: #{travel_params}"
      )
    end
  end

  def update
    @travel = Travel.find(params[:id])
    if @travel.update(travel_params)
      redirect_to travel_path(@travel.id)
    else
      render edit_travel_path
      logger.info(
        ">>>>>>CONTROLLER: Error to update travel with params: #{travel_params}"
      )
    end
  end

  def show
    @travel = Travel.find params[:id]
  end

  private

  def travel_params
    params.require(:travel).permit(:name,
                                   :destination,
                                   :init_date,
                                   :final_date,
                                   :description)
  end
end
