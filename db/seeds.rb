require 'csv'

datafile = Rails.root + 'db/data/appointment_data.csv'

# "%d/%m,%Y %H:%M"
CSV.foreach(datafile, headers: true) do |row|
  Appointment.create! do |appt|
    appt.start_time = DateTime.strptime(row['start_time'], "%m/%d/%Y %H:%M")
    appt.end_time = DateTime.strptime(row['end_time'], "%m/%d/%Y %H:%M")
    appt.first_name = row['first_name']
    appt.last_name = row['last_name']
    appt.comments = row['comments']
    appt.user_id = 1
  end
end
