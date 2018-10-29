# Travel model
class Travel < ActiveRecord::Base
  has_many :days
  validates :name, presence: true
  validates :destination, presence: true
  validates :init_date, presence: true
  validates :final_date, presence: true
  validates :description, presence: true

  def duration
    @travel.days.size
  end
end
