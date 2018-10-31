# Day class
class DaysController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create_travel_days(travel)
    raise invalid_dates_error_message unless validate_travel_date(travel.init_date, travel.final_date)

    travel_days = []
    travel_duration_in_days = ((travel.final_date - travel.init_date) / 1.day) + 1
    current_ordinal_day = 0
    current_date = travel.init_date.to_date

    while current_ordinal_day < travel_duration_in_days
      day_travel = create_day(travel, current_date)
      travel_days << day_travel
      current_ordinal_day += 1
      current_date += 1.day
    end
  end

  def create_day(travel, current_date)
    return false if days_already_exists(travel.days, current_date)

    day_travel = Day.new
    day_travel.date = current_date
    day_travel.travel_id = travel.id
    unless day_travel.save
      logger.info("DaysController: Error to create day with params|
        #{current_date} to #{travel.id}")
    end
    day_travel
  end

  def update_days(travel, new_travel_duration)
    raise invalid_dates_error_message unless validate_travel_date(travel.init_date, travel.final_date)

    init_date = travel.init_date
    travel.days.order(:date).each do |day|
      new_date = { date: init_date }
      unless day.update(new_date) # Verify if its only upadate 'date' value
        logger.info("DaysController: Error to update day with params|
        #{current_date} to #{travel.id}")
      end
      init_date += 1.day
    end
  end

  private

  def days_already_exists(travel_days, current_date)
    matching_days = []
    travel_days.each do |day|
      matching_days << day if day.date == current_date
    end
    return false if matching_days.empty?

    true
  end

  def invalid_dates_error_message
    # TODO: create logger class with messages
    'The fisrt day should be minor or equal to the last day'
  end

  def validate_travel_date(init_date, final_date)
    init_date.to_date <= final_date.to_date
  end
end
