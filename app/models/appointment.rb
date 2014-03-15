class Appointment < ActiveRecord::Base
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :description
end
