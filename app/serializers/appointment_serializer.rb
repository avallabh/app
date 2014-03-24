class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :start_time, :end_time, :first_name, :last_name, :comments
end
