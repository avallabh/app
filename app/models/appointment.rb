class Appointment < ActiveRecord::Base
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :description
  validates :start_time, :end_time, :overlap => {:exclude_edges => ["start_time", "end_time"]}

  belongs_to :user,
    inverse_of: :appointments

  default_scope { order('start_time DESC') }
end
