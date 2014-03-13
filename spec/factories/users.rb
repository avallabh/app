# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Smith"
    sequence :email do |n|
      "awesome#{n}@gmail.com"
    end
    password "password"
    password_confirmation "password"
  end
end
