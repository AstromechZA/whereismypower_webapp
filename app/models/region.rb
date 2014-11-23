class Region < ActiveRecord::Base
  has_many :areas, dependent: :destroy
  has_many :schedules, class_name: 'Schedule', dependent: :destroy
  has_many :region_updates
  belongs_to :active_schedule, class_name: 'Schedule'
end
