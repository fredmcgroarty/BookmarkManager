require 'spec_helper'

feature "User can have a profile" do

	before(:each) {
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
    Link.create(:url => "http://www.makersacademy.com",
                :title => "Makers Academy", 
                :time => "#{time_gen}", 
                :tags => [Tag.first_or_create(:text => 'education')])
    Link.create(:url => "http://www.google.com", 
                :title => "Google", 
                :time => "#{time_gen}",
                :description => "Primary Search Engine",
                :user_email => "test@test.com", 
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.bing.com", 
                :title => "Bing", 
                :time => "#{time_gen}", 
                :tags => [Tag.first_or_create(:text => 'search')])
    Link.create(:url => "http://www.code.org", 
                :title => "Code.org", 
                :time => "#{time_gen}", 
                :tags => [Tag.first_or_create(:text => 'education')])
  }

  scenario "and see their page with links" do 
  	visit '/'
  	sign_in('test@test.com', 'test')
  	visit '/profile'
  	expect(page).to have_content("Makers Academy")
  end

