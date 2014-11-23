class AreaSchedule < ActiveRecord::Base
  belongs_to :area
  belongs_to :schedule
end
