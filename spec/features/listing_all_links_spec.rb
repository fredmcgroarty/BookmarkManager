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
    Link.create(:url => "http://www.google.com", 
                :title => "Google", 
                :time => "#{time_gen}",
                :description => "Primary Search Engine",
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

  # scenario "and if no description is available a default will take its place" do 
  #   visit '/'
  #   sign_in('test@test.com', 'test') 
  #   expect(page).to have_content("A description has not been added")
  # end

  def time_gen 
    time = Time.now
    t = time.strftime("%T on %d-%m-%Y")
  end 

  def add_link(url, title, tags = [])
    within ('#container') do 
      fill_in 'url', :with => url 
      fill_in 'title', :with => title 
      fill_in 'tags', :with => tags.join(' ')
      click_button 'Add link'
    end
  end 


end