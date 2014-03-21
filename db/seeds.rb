# require 'csv'

# datafile = Rails.root + 'db/data/appointment_data.csv'

# CSV.foreach(datafile, headers: true) do |row|
#   Appointment.find_or_create_by(appointment) do |appt|
#     appt.start_time = row['start_time']
#     appt.end_time = row['end_time']
#     appt.first_name = row['first_name']
#     appt.last_name = row['last_name']
#     appt.comments = row['comments']
#   end
# end
