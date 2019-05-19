# Travel model
class Travel < ActiveRecord::Base
  has_many :days, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :destination, presence: true
  validates :init_date, presence: true
  validates :final_date, presence: true
  validates :description, presence: true

  def duration
    @travel.days.size
  end
end
