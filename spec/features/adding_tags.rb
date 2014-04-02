require 'spec_helper'

feature "user browses and adds tags" do 

	before(:each) {
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  }

  scenario "filtered links by tags" do
    visit '/'
    sign_in('test@test.com', 'test') 
  	visit '/tags/search'
  	expect(page).not_to have_content("Code.org")
  	expect(page).to have_content("Google")
  	expect(page).to have_content("Bing")
	end


