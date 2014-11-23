class Region < ActiveRecord::Base
  has_many :areas, dependent: :destroy
  has_many :schedules, class_name: 'Schedule', dependent: :destroy
  belongs_to :active_schedule, class_name: 'Schedule'
end
