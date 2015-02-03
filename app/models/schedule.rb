class Schedule < ActiveRecord::Base
  validates_presence_of :area
  validates_presence_of :stage
end
