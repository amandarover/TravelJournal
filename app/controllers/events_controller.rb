# Events Controller
class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    @event = Event.new
    @travel = Travel.find(travel_id)
    @day = Day.find(day_id)
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

  def show
    @event = Event.find(params[:id])
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
    init_date <= final_date
  end

  def invalid_dates_error_message
    'The starting time should be minor or equal to the ending time'
  end
end
