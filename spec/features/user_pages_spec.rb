require 'rails_helper'

describe "the creating a new user process" do
  it "will add a new user" do
    visit '/'
    click_link 'Sign Up'
    fill_in 'Username', with: 'foo'
    fill_in 'Email', with: 'foo@foo.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end

describe "logging in" do
  it "Will log in a user" do
    user = FactoryGirl.create(:user)
    visit '/'
    click_link 'Login'
    fill_in 'Login', with: user.username
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end

describe 'logging out' do
  it 'will log out a user' do
    user = FactoryGirl.create(:user)
    login(user)
    click_link user.username
    click_link 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end
end

describe 'visiting user profile' do
  it "will go to a users profile" do
    user = FactoryGirl.create(:user)
    login(user)
    click_link user.username
    click_link 'Profile'
    expect(page).to have_content user.email
  end

end