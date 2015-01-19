require 'spec_helper'

feature "User sends a new message" do 
  scenario "when browsing the homepage" do
    expect(Message.count).to eq(0)
    visit '/'
    send_message("Test", "This is a test")
    expect(Message.count).to eq(1)
    message = Message.first
    expect(message.title).to eq("Test")
    expect(message.body).to eq("This is a test")
  end

  def send_message(title, body)
    within('#new-message') do
      fill_in 'title', :with => title
      fill_in 'body', :with => body
      click_button 'Send message'
    end
  end
end