require 'spec_helper'
include SessionHelper

feature "User browses the list of links" do

  before(:each) {
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
    Link.create(:url => "http://www.makersacademy.com",
                :title => "Makers Academy", 
                :time => "#{time_gen}", 
                :tags => [Tag.first_or_create(:text => 'education')])
  }


#this is passing for the wrong reasons 
  scenario "when opening the home page" do
    visit '/'
    sign_in('test@test.com', 'test')
    visit '/'
    expect(page).to have_content("Makers Academy")#footer
  end


  scenario "and sees the time the link was added" do 
    visit "/sessions/new"
    sign_in('test@test.com', 'test')
    visit "/links/new"
    add_link("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])   
    expect(page).to have_content(time_gen)
  end

  scenario "and sees a record of the user who added the link" do 
    visit "/sessions/new"
    sign_in('test@test.com', 'test')
    visit "/links/new"
    add_link("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])   
    expect(page).to have_content("test@test.com")
  end

  scenario "and if no description is available a default will take its place" do 
 visit "/sessions/new"
    sign_in('test@test.com', 'test')
    visit "/links/new"
    add_link("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])  
    expect(page).to have_content("A description has not been added")
  end

end