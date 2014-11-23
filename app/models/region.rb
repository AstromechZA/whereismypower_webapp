class Region < ActiveRecord::Base
  has_many :areas, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_one :active_schedule, class_name: 'Schedule'
end
