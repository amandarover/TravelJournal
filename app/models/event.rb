# Event model
class Event < ActiveRecord::Base
  validates :type, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :starting_time, presence: true
  validates :ending_time, presence: true
  validates :pricing, presence: true
  validates :description, presence: true
end
