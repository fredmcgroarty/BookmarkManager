require 'spec_helper'

feature "User can have a profile" do

	before(:each) {
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
    Link.create(:url => "http://www.makersacademy.com",
                :title => "Makers Academy", 
                :tags => [Tag.first_or_create(:text => 'education')])
                :description => "xxxxxx"
  }

  scenario "and see their page with links" do 
  	visit '/'
  	sign_in('test@test.com', 'test')
  	visit '/profile'
  	expect(page).to have_content("Makers Academy")
  end

