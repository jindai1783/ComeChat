require 'spec_helper'

feature "User signs up" do

  scenario "when being a new user visiting the site" do
    expect{sign_up}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, tesco")
    expect(User.first.email).to eq("test@test.com")
  end

  scenario "with a password that doesn't match" do
    expect{sign_up('a@a.com', 'a', 'ace', 'pass', 'wrong')}.to change(User, :count).by(0)
    expect(current_path).to eq('/users')
    expect(page).to have_content("Sorry, your passwords don't match")
  end

  scenario "with a email that is already registered" do
    expect{sign_up}.to change(User, :count).by(1)
    expect{sign_up}.to change(User, :count).by(0)
    expect(page).to have_content("This email is already registered")
  end

  def sign_up(email = "test@test.com", name = "Test", username = "tesco",
              password = "1234", password_confirmation = "1234")
    visit 'users/new'
    # puts "\e[33m$$$$$\e[0m" * 5
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :name, :with => name
    fill_in :username, :with => username
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end
  
end

feature "User signs in" do

  before(:each) do
    User.create(:email => "photo@photo.com",
                :name => "Photo",
                :username => "popcorn",
                :password => "1234",
                :password_confirmation => "1234")
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, popcorn")
    sign_in
    expect(page).to have_content("Welcome, popcorn")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, popcorn")
    sign_in("photo@photo.com", "wrong")
    expect(page).not_to have_content("Welcome, popcorn")
  end

end

feature "User signs out" do

  before(:each) do
    User.create(:email => "photo@photo.com",
                :name => "Photo",
                :username =>"popcorn",
                :password => "1234",
                :password_confirmation => "1234")
  end

  scenario "while being signed in" do
    visit '/'
    sign_in
    expect(page).to have_content("Welcome, popcorn")
    click_button("Sign out")
    expect(page).to have_content("Goodbye!")
  end

end


def sign_in(email = "photo@photo.com", password = "1234")
  visit 'sessions/new'
  fill_in 'email', :with => email
  fill_in 'password', :with => password
  click_button("Sign in")
end






