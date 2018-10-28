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
      DaysController.new.create_travel_days(@travel)
      redirect_to travel_path(@travel.id)
    else
      render new_travel_path
      logger.info("TravelsController: Error to save travel with params:
        #{travel_params}")
    end
  end

  def update
    @travel = Travel.find(params[:id])
    # TODO: verify if exist params to update (to not do a useless update)
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
    @travel = Travel.find(params[:id])
  end

  def destroy
    @travel = Travel.find(params[:id])
    # TODO: verify if destroy its ok and don't have any dependencies
    @travel.destroy
    redirect_to travels_path
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
