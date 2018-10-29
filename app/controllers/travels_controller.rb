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
      logger.info("TravelsController: Error to save travel with params| #{travel_params}")
      render new_travel_path
    end
  rescue StandardError => e
    logger.info("DAYS_CONTROLLER: Error to create_travel_days: #{e.message}")
    @travel.errors.add(:base, invalid_dates_error_message)
    render new_travel_path
  end

  def update
    @travel = Travel.find(params[:id])
    # TODO: verify if exist params to update (to not do a useless update) (Rails do that?)
    new_duration = ((params[:travel][:final_date].in_time_zone - params[:travel][:init_date].in_time_zone) / 1.day) + 1
    raise invalid_duration_error_message unless @travel.days.count == new_duration.to_i

    if @travel.update(travel_params)
      DaysController.new.update_days(@travel)
      redirect_to travels_path
    else
      # The eror printed on html will not work because I am doing a redirect
      logger.info("TravelsController: Error to update travel with params|
        #{travel_params}")
      redirect_to edit_travel_path(@travel.id)
    end
  rescue StandardError => e
    logger.info("TravelsController: Error to update travel days: #{e.message}")
    @travel.errors.add(:base, invalid_duration_error_message)
    # The eror printed on html will not work because I am doing a redirect
    redirect_to edit_travel_path(@travel.id)
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

  def add_one_day # TODO: Move to DaysController
    @travel = Travel.find(params[:id])
    init_date = true if params[:add_on_first_day]
    final_date = true if params[:add_on_last_day]
    if final_date
      @travel.final_date += 1.day
      @travel.save
      DaysController.new.create_day(@travel, @travel.final_date)
    elsif init_date
      @travel.init_date -= 1.day
      @travel.save
      DaysController.new.create_day(@travel, @travel.init_date)
    end
    redirect_to travel_path(@travel.id)
  end

  private

  def travel_params
    params.require(:travel).permit(:name,
                                   :destination,
                                   :init_date,
                                   :final_date,
                                   :description)
  end

  def invalid_dates_error_message
    'The fisrt day should be minor or equal to the last day'
  end

  def invalid_duration_error_message
    'The duration of the travel can not be changed'
  end
end
