class Appointment < ActiveRecord::Base
  validates_presence_of :month
  validates_presence_of :date
  validates_presence_of :hour
  validates_presence_of :minute
  validates_presence_of :meridiem
  validates_presence_of :description

end
