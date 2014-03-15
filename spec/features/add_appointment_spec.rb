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
    select "3", from: 'appointment_start_time_1i'
    select "14", from: "Date"
    select "8", from: "Hour"
    select "0", from: "Minutes"
    select "AM", from: "AM/PM"
    fill_in 'Description', with: "I'd like to schedule an appointment."
    click_button 'Add'

    expect(page).to have_content('Appointment saved')
    expect(page).to_not have_content("can't be blank")
    expect(page).to_not have_content('Error')
  end

  scenario "authenticated user doesn't fill out all the fields" do
    click_link 'Add Appointment'
    select "3", from: "Month"
    select "14", from: "Date"
    select "8", from: "Hour"
    select "0", from: "Minutes"
    fill_in 'Description', with: "In a hurry."
    click_button 'Add'

    expect(page).to_not have_content('Appointment added')
    #expect(page).to have_content("can't be blank")
    expect(page).to have_content('Error: Appointment not saved')
  end

  scenario "unauthenticated user tries to add appointment" do
    click_link 'Sign Out'
    visit new_appointment_path

    expect(page).to_not have_content('Description')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

end
