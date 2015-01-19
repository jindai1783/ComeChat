require 'spec_helper'

feature "User sends a new message" do 
  scenario "when browsing the homepage" do
    expect(Message.count).to eq(0)
    visit '/'
    send_message("Test", "This is a test", "Pot")
    expect(Message.count).to eq(1)
    message = Message.first
    expect(message.title).to eq("Test")
    expect(message.body).to eq("This is a test")
  end

  scenario "with a user" do
    visit "/"
    send_message("Test",
                 "This is a test",
                 "Pot")
    message = Message.first
    expect(message.user).to include("Pot")
  end

  def send_message(title, body, user)
    within('#new-message') do
      fill_in 'title', :with => title
      fill_in 'body', :with => body
      fill_in 'user', :with => user
      click_button 'Send message'
    end
  end
end