class Appointment < ActiveRecord::Base
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :description

  belongs_to :user,
    inverse_of: :appointments

  default_scope { order('start_time DESC') }
end
