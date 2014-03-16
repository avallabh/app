require 'spec_helper'

feature 'add appointments', %Q{
  As a authenticated user
  I want to add appointments
  So I can add/edit/delete/view appointments
  } do

# ACCEPTANCE CRITERIA
# * If user is not logged in, display a sign-in / sign-up option
# * Add appointment: name, description, time, date
# * Edit/Delete only my appointments

  let(:user) { FactoryGirl.create(:user) }

  before :each do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
  end

  scenario "authenticated user adds appointment" do
    click_link 'Add Appointment'
    select "2014", from: 'appointment_start_time_1i'
    select "March", from: 'appointment_start_time_2i'
    select "20", from: 'appointment_start_time_3i'
    select "10", from: 'appointment_start_time_4i'
    select "00", from: 'appointment_start_time_5i'
    fill_in 'Description', with: "I'd like to schedule an appointment."
    click_button 'Add'

    expect(page).to have_content('Appointment saved')
    expect(page).to_not have_content("can't be blank")
    expect(page).to_not have_content('Error')
  end

  scenario "authenticated user doesn't fill out all the fields" do
    click_link 'Add Appointment'
    select "2014", from: 'appointment_start_time_1i'
    select "March", from: 'appointment_start_time_2i'
    select "21", from: 'appointment_start_time_3i'
    select "11", from: 'appointment_start_time_4i'
    select "15", from: 'appointment_start_time_5i'
    click_button 'Add Appointment'

    # expect(page).to_not have_content('Appointment added')
    # expect(page).to have_content("can't be blank")
    expect(page).to have_content('Please fill out this field')
    expect(page).to have_content('New Appointment')
  end

  scenario "unauthenticated user tries to add appointment" do
    click_link 'Sign Out'
    visit new_appointment_path

    expect(page).to_not have_content('Description')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

end
