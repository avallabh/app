FactoryGirl.define do
  factory :appointment do
    start_time "2014-04-01 10:00:00"
    end_time "2014-04-01 10:15:00"
    sequence :first_name do |n|
      "John-#{n}"
    end
    last_name "Snow"
    comments "You know nothing, John Snow"
    user_id 1
  end
end
