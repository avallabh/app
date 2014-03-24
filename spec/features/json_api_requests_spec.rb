require 'spec_helper'

describe 'PostSerializer' do
  it "returns JSON for the API" do
    serializer = AppointmentSerializer.new Appointment.new(id:899, start_time: "2014-11-29 14:00", end_time: "2014-11-29 14:05", first_name: "Alex", last_name: "Ich", comments: "Hello", user_id:1, created_at: "2014-03-24 15:00", updated_at: "2014-03-24 15:00")
    expect(serializer.to_json).to eql('{"appointment":{"id":899,"start_time":"2014-11-29T14:00:00.000Z","end_time":"2014-11-29T14:05:00.000Z","first_name":"Alex","last_name":"Ich","comments":"Hello"}}')
  end
end
