require 'spec_helper'

feature "User signs up" do

  scenario "when being a new user visiting the site" do
    expect{sign_up}.to change(User, :count).by(1)
    expect(page).to have_content("Welcome, test@test.com")
    expect(User.first.email).to eq("test@test.com")
  end

  scenario "with a password that doesn't match" do
    expect{sign_up('a@a.com', 'pass', 'wrong')}.to change(User, :count).by(0)
  end

  def sign_up(email = "test@test.com", password = "1234", 
              password_confirmation = "1234")
    visit 'users/new'
    puts "\e[33m$$$$$\e[0m" * 5
    expect(page.status_code).to eq(200)
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
  end
  
end