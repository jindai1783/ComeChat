require 'spec_helper'

feature "Users browses the list of messages" do 

  before(:each) {
    User.create(:name => "Pot")
    Message.create(:title => "Test",
                   :body => "This is a test",
                   :user => "Pot")
  }

  scenario "when opening the home page" do 
    visit '/'
    expect(page).to have_content("Test")
  end
end