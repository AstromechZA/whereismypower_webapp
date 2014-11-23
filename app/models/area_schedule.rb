class AreaSchedule < ActiveRecord::Base
  belongs_to :area
  belongs_to :schedule

  validates_presence_of :area
  validates_presence_of :schedule
end
