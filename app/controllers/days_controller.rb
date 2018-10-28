# Day class
class DaysController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create_travel_days(travel)
    raise invalid_dates_error_message unless validate_travel_date(travel.init_date, travel.final_date)

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
  end

  private

  def invalid_dates_error_message
    'The fisrt day should be minor than the last day'
  end

  def validate_travel_date(init_date, final_date)
    init_date.to_date < final_date.to_date
  end
end
