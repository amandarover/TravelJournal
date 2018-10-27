# Travel model
class Travel < ActiveRecord::Base
  validates :name, presence: true
  validates :destination, presence: true
  validates :init_date, presence: true
  validates :final_date, presence: true
  validates :description, presence: true
end
