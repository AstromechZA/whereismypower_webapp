class Schedule < ActiveRecord::Base
  belongs_to :region
  has_many :area_schedules

  validates_presence_of :region
end
