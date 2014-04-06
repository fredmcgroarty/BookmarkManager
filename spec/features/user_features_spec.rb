require 'spec_helper'
include SessionHelper

feature "User can have a profile" do

	before(:each) {
    User.create(:email => "bill@test.com",
                :username => "bill",
                :password => 'test',
                :password_confirmation => 'test')
    User.create(:email => "fred@test.com",
                :username => 'fred',
                :password => 'test',
                :password_confirmation => 'test',)
    User.create(:email => "othertest@test.com",
                :username => 'geoff',
                :password => 'test',
                :password_confirmation => 'test')
  }

  scenario "and see their page with links" do 
  	visit '/'
  	sign_in('fred@test.com', 'test')
    visit "/links/new"
    add_link("www.jamesbrown.com", 
                "James Brown", 
                ['music', 'funk', 'legend'])
  	visit '/profile/fred'
  	expect(page).to have_content("James Brown")
    visit '/profile/bill'
    expect(page).not_to have_content("James Brown")
  end

  scenario "and remove links from their profile page" do 
    visit '/'
    sign_in('fred@test.com', 'test')
    visit "/links/new"
    add_link("www.jamesbrown.com", 
                "James Brown", 
                ['music', 'funk', 'legend'])
    visit '/profile/fred'
    expect(page).to have_content("James Brown")    

end

