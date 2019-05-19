# Event model
class Event < ActiveRecord::Base
  belongs_to :day
  validates :category, presence: true
  validates :name, presence: true
  validates :starting_time, presence: true
  validates :ending_time, presence: true
end
