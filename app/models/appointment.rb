class Appointment < ActiveRecord::Base

  def initialize(start_date='2014-01-01', end_date='2019-12-31')
    @start_time = start_date.to_date
    @end_time = end_date.to_date
  end

  def find_appointments_in_range(start_time, end_time)
    Appointment.where("start_time >= ? AND end_time <= ?",
     @start_time, @end_time).order(:start_time)
  end

  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :first_name
  validates_presence_of :last_name

  validates :start_time, :end_time, :overlap => {:exclude_edges => ["start_time", "end_time"]}

  belongs_to :user,
    inverse_of: :appointments

  default_scope { order('start_time DESC') }

end
