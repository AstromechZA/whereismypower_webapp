class Area < ActiveRecord::Base
  belongs_to :region
  has_many :area_schedules
end