require 'spec_helper'

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
  scenario "when opening the home page" do
    visit '/'
    sign_in('test@test.com', 'test')
    visit '/'
    expect(page).to have_content("Makers Academy")
  end



  scenario "and sees the time the link was added" do 
    visit '/'
    sign_in('test@test.com', 'test') 
    expect(page).to have_content("added: @ #{time_gen}")
  end

  scenario "and sees a record of the user who added the link" do 
    visit "/sessions/new"
    sign_in('test@test.com', 'test')
    expect(page).to have_content("by test@test.com")
  end


  def time_gen 
    time = Time.now
    t = time.strftime("%T on %d-%m-%Y")

  end 
end