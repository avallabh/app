class Appointment < ActiveRecord::Base
  default_scope { order('start_time DESC') }

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :description

  belongs_to :user,
    inverse_of: :appointments
end
