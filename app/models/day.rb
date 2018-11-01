# Day Model
class Day < ActiveRecord::Base
  belongs_to :travel
  has_many :events, dependent: :destroy
end
