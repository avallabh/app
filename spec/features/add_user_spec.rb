require 'spec_helper'

feature 'guest can register', %Q{
As a guest user
I want to create a free account
So I can add/edit/delete/view appointments
} do

# ACCEPTANCE CRITERIA
# * If user is not logged in, display a sign-in / sign-up option
# * User provides required info: first/last name, password, password confirmation, email
# * If signed in, display sign-out option

  scenario 'user signs up' do
    password = "password"
    email = "person@example.com"

    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "Joe"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: email
    fill_in "user_password", with: password
    fill_in "Password Confirmation", with: password
    click_button "Sign Up"

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')
    expect(page).to_not have_content('Sign Up')
  end

  scenario 'required information not supplied' do
    visit root_path
    click_link "Sign Up"
    click_button "Sign Up"

    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'password confirmation fails' do
    email = "person@example.com"

    visit root_path
    click_link "Sign Up"
    fill_in "First Name", with: "Joe"
    fill_in "Last Name", with: "Smith"
    fill_in "Email", with: email
    fill_in "user_password", with: "password"
    fill_in "Password Confirmation", with: "theyDontMatch"
    click_button "Sign Up"

    expect(page).to have_content("doesn't match")
    expect(page).to_not have_content("Sign Out")
  end

  scenario 'registered user correctly signs in' do
    test = FactoryGirl.create(:user)

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: test.email
    fill_in "Password", with: test.password
    click_button "Sign In"

    expect(page).to have_content('Welcome back')
    expect(page).to_not have_content('Sign In')
    expect(page).to_not have_content('Error')
  end

  scenario 'registered user does not correctly sign in' do
    test = FactoryGirl.create(:user)

    visit root_path
    click_on "Sign In"
    fill_in "Email", with: test.email
    fill_in "Password", with: '12345678'
    click_button "Sign In"

    expect(page).to_not have_content('Welcome back')
    expect(page).to have_content('Sign In')
    expect(page).to have_content('Invalid email or password')
  end

end
