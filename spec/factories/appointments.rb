FactoryGirl.define do
  factory :appointment do
    start_time "2014-04-01 10:00:00"
    end_time "2014-04-01 10:15:00"
    description "Appointment factory"
    user_id 1
  end
end
