# Events Controller
class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
    @event = Event.new
    @travel = Travel.find(params[:travel_id])
    @day = Day.find(params[:day_id])
  end

  def create(travel_id, day_id)
    @event = Event.new(event_params)
    if @event.save
      DaysController.new.create_event_days(@event)
      redirect_to event_path(@event.id)
    else
      logger.info("eventsController: Error to save event with params| #{event_params}")
      render new_event_path
    end
  end

  # def create_event(day)
  #   raise invalid_dates_error_message unless validate_event_date(event.init_date, event.final_date)

  #   event_events = []
  #   event_duration_in_events = ((event.final_date - event.init_date) / 1.day) + 1
  #   current_ordinal_day = 0
  #   current_date = event.init_date.to_date

  #   while current_ordinal_day < event_duration_in_events
  #     day_event = create_day(event, current_date)
  #     event_events << day_event
  #     current_ordinal_day += 1
  #     current_date += 1.day
  #   end
  # end

  private

  def event_params
    params.require(:event).permit(:type,
                                  :name,
                                  :address,
                                  :starting_time,
                                  :ending_time,
                                  :pricing,
                                  :description)
  end
end
