# Travel model
class Travel < ActiveRecord::Base
  belongs_to :user
  has_many :days, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :init_date, presence: true
  validates :final_date, presence: true

  def duration
    @travel.days.size
  end
end
