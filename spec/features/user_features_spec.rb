require 'spec_helper'
include SessionHelper

feature "User can have a profile" do

	before(:each) {
    User.create(:id => "2",
                :email => "othertest@test.com",
                :password => 'test',
                :password_confirmation => 'test',)
    User.create(:id => "1",
                :email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
    User.create(:email => "othertest@test.com",
                :password => 'test',
                :password_confirmation => 'test')
    Link.create(:url => "http://www.Jamesbrown.com",
                :title => "James Brown", 
                :tags => [Tag.first_or_create(:text => 'education')],
                :description => "xxxxxx")
  }

  scenario "and see their page with links" do 
  	visit '/'
  	sign_in('test@test.com', 'test')
    visit "/links/new"
    add_link("www.jamesbrown.com", 
                "James Brown", 
                ['music', 'funk', 'legend'])
  	visit '/profile/1'
  	expect(page).to have_content("James Brown")
    visit '/profile/2'
    expect(page).not_to have_content("James Brown")
  end


end

