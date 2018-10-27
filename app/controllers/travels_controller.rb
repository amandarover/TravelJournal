# Class of Travels
class TravelsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
  end

  def create
    @travel = Travel.new(params[:travel].permit(:name,
                                                :destination,
                                                :init_date,
                                                :final_date,
                                                :description))
    @travel.save
    redirect_to dashboard_index_path
  end
end
