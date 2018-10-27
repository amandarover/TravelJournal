# Class of Travels
class TravelsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    @travels = Travel.all
  end

  def new
  end

  def create
    byebug
    @travel = Travel.new(travel_params)

    if @travel.save
      redirect_to travel_path(@travel.id)
    else
      redirect_to new_travel_path
      # TODO: print error message
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
