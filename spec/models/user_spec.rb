require 'spec_helper'

describe User do
  it { should have_valid(:first_name).when("Joe") }
  it { should_not have_valid(:first_name).when(nil, '') }

  it { should have_valid(:last_name).when("Smith") }
  it { should_not have_valid(:last_name).when(nil, '') }

  it { should have_valid(:email).when("person@example.com") }
  it { should_not have_valid(:email).when(nil, '', 'bob', 'nope@com', 'nah.com') }

  it 'has matching passwords' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'wrongpass'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
