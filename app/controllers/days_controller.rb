# Day class
class DaysController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create_travel_days(travel)
    raise invalid_dates_error_message unless validate_travel_date(travel.init_date, travel.final_date)

    travel_days = []
    travel_duration_in_days = ((travel.final_date - travel.init_date) / 1.day)
    current_ordinal_day = 0
    current_date = travel.init_date.to_date

    while current_ordinal_day <= travel_duration_in_days
      day_travel = create_day(travel, current_date)
      travel_days << day_travel
      current_ordinal_day += 1
      current_date += 1.day
    end
  end

  def create_day(travel, current_date)
    return false if day_already_exists(travel, current_date)

    day_travel = Day.new
    day_travel.date = current_date
    day_travel.travel_id = travel.id
    day_travel.save
  end

  private

  def day_already_exists(travel, current_date)
    travel.days.each do |day|
      return true if day.date == current_date
    end
  end

  def invalid_dates_error_message
    'The fisrt day should be minor than the last day'
  end

  def validate_travel_date(init_date, final_date)
    init_date.to_date < final_date.to_date
  end
end
