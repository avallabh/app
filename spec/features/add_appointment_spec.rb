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
  let(:appointment) { FactoryGirl.create(:appointment) }

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
    select "April", from: 'appointment_start_time_2i'
    select "1", from: 'appointment_start_time_3i'
    select "10 AM", from: 'appointment_start_time_4i'
    select "00", from: 'appointment_start_time_5i'

    select "2014", from: 'appointment_end_time_1i'
    select "April", from: 'appointment_end_time_2i'
    select "1", from: 'appointment_end_time_3i'
    select "10 AM", from: 'appointment_end_time_4i'
    select "10", from: 'appointment_end_time_5i'

    fill_in 'First Name', with: "Orianna"
    fill_in 'Last Name', with: "Reveck"
    fill_in 'Comments', with: "The Lady of Clockwork"
    click_button 'Add'

    expect(page).to have_content('Appointment saved')
    expect(page).to_not have_content("can't be blank")
    expect(page).to_not have_content('Error')
  end

  scenario "authenticated user doesn't fill out all the fields" do
    click_link 'Add Appointment'
    select "2014", from: 'appointment_start_time_1i'
    select "May", from: 'appointment_start_time_2i'
    select "7", from: 'appointment_start_time_3i'
    select "11 AM", from: 'appointment_start_time_4i'
    select "15", from: 'appointment_start_time_5i'

    select "2014", from: 'appointment_end_time_1i'
    select "May", from: 'appointment_end_time_2i'
    select "7", from: 'appointment_end_time_3i'
    select "11 AM", from: 'appointment_end_time_4i'
    select "30", from: 'appointment_end_time_5i'
    click_button 'Add Appointment'

    expect(page).to_not have_content('Appointment added')
    expect(page).to have_content('Error: Appointment not saved')
    expect(page).to have_content('New Appointment')
  end

  scenario "unauthenticated user tries to add appointment" do
    click_link 'Sign Out'
    visit new_appointment_path

    expect(page).to_not have_content('New Appointment')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario "authenticated user can only add future appointments" do
    click_link 'Add Appointment'

    select "2014", from: 'appointment_start_time_1i'
    select "January", from: 'appointment_start_time_2i'
    select "1", from: 'appointment_start_time_3i'
    select "08 AM", from: 'appointment_start_time_4i'
    select "15", from: 'appointment_start_time_5i'

    select "2014", from: 'appointment_end_time_1i'
    select "January", from: 'appointment_end_time_2i'
    select "1", from: 'appointment_end_time_3i'
    select "08 AM", from: 'appointment_end_time_4i'
    select "30", from: 'appointment_end_time_5i'
    click_button 'Add Appointment'

    expect(page).to have_content('Error: Appointment must be in the future')
    expect(page).to_not have_content('Appointment saved')
  end

  scenario "authenticated user deletes an appointment" do
    deleted_appointment = FactoryGirl.create(:appointment)
    visit root_path
    click_link 'Delete'

    expect(page).to have_content('Appointment was successfully deleted')
    expect(page).to_not have_content('Error')
    expect(page).to_not have_content(appointment.start_time)
  end

  scenario "user filters appointments by time" do
    valid_appointment1 = FactoryGirl.create(:appointment, start_time: '10:00 AM', end_time: '10:30 AM')
    valid_appointment2 = FactoryGirl.create(:appointment, start_time: '12:45 PM', end_time: '1:00 PM')
    invalid_appointment1 = FactoryGirl.create(:appointment, start_time: '9:50 AM', end_time: '10:00 AM')
    invalid_appointment2 = FactoryGirl.create(:appointment, start_time: '2:30 PM', end_time: '3:00 PM')

    visit root_path
    select "10:00 AM", from: 'start_time'
    select "2:00 PM", from: 'End Time'
    click_button 'Find Appointments In Range'

    expect(page).to have_content(valid_appointment1.start_time)
    expect(page).to have_content(valid_appointment2.start_time)
    expect(page).to_not have_content(invalid_appointment1.start_time)
    expect(page).to_not have_content(invvalid_appointment2.start_time)
  end
end
