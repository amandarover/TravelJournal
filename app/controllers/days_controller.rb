# Day class
class DaysController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create_travel_days(travel)
    # next unless validate_travel_date(init_date, final_date) TODO: Verify if the dates are valid (init should be minor than final)
    travel_days = []
    travel_days_ordinal_count = ((travel.final_date - travel.init_date) / 1.day)
    current_ordinal_day = 0
    current_day = travel.init_date.to_date - 1.day

    while current_ordinal_day <= travel_days_ordinal_count
      day_travel = Day.new
      day_travel.date = (current_day += 1.day)
      day_travel.travel_id = travel.id
      day_travel.save
      travel_days << day_travel
      current_ordinal_day += 1
    end
  rescue StandardError => e
    logger.info("DAYS_CONTROLLER: Error to create: #{e.message}")
    puts e.message
    puts e.backtrace.inspect
  end
end
