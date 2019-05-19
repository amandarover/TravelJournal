# Events Controller
class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate

  def new
    @event = Event.new
    @day = Day.find(day_id)
    @travel = Travel.find(travel_id)
  end

  def edit
    @event = Event.find(params[:id])
    @day = Day.find(@event.day_id)
    @travel_id = @day.travel_id
  end

  def create
    @event = Event.new(event_params)
    raise invalid_dates_error_message unless validate_event_time(@event.starting_time, @event.ending_time)

    @event.day_id = day_id
    if @event.save
      redirect_to travel_path(travel_id)
    else
      logger.info("EventsController: Error to create event with params| #{event_params}")
      render new_travel_day_event_path(travel_id, day_id)
    end
  end

  def update
    @event = Event.find(params[:id])
    # TODO: verify if exist params to update (to not do a useless update) (Rails do that?)
    raise invalid_dates_error_message unless validate_event_time(@event.starting_time, @event.ending_time)

    if @event.update(event_params)
      redirect_to travel_path(travel_id)
    else
      logger.info("eventsController: Error to update event with params|
        #{event_params}")
    end
  rescue StandardError => e
    logger.info("eventsController: Error to update event days: #{e.message}")
    @event.errors.add(:base, invalid_dates_error_message)
    # The eror printed on html will not work because I am doing a redirect
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to travel_path(travel_id)
  end

  private

  def event_params
    params.require(:event).permit(:category,
                                  :name,
                                  :address,
                                  :starting_time,
                                  :ending_time,
                                  :pricing,
                                  :description)
  end

  def travel_id
    params[:travel_id]
  end

  def day_id
    params[:day_id]
  end

  def validate_event_time(init_date, final_date)
    init_date.to_s <= final_date.to_s
  end

  def invalid_dates_error_message
    'The starting time should be minor or equal to the ending time'
  end
end
