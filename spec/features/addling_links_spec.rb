require 'spec_helper'
require_relative 'helpers/session'
include SessionHelper

	feature "User adds a new link" do 

    before(:each) do 
    User.create(:email => "test@test.com",
                :password => 'test',
                :password_confirmation => 'test')
  end


		scenario "when browsing the homepage" do 
      visit "/sessions/new"
      sign_in('test@test.com', 'test')
			expect(Link.count).to eq(0)
			visit "/links/new" 
			add_link("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])
			expect(Link.count).to eq(1)
			link = Link.first 
			expect(link.url).to eq("http://www.makersacademy.com/")
			expect(link.title).to eq("Makers Academy")
		end

	scenario "with a few tags" do
    visit "/sessions/new"
    sign_in('test@test.com', 'test')
    visit "/links/new"
    add_link("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])    
    link = Link.first
    expect(link.tags.map(&:text)).to include("education")
    expect(link.tags.map(&:text)).to include("ruby")
  end

  scenario "and generates a time tag" do
    visit "/sessions/new"
    sign_in('test@test.com', 'test')
    visit "/links/new"
    add_link("http://www.makersacademy.com/", 
                "Makers Academy", 
                ['education', 'ruby'])    
    link = Link.first   
    expect(link.time).to eq(time_gen)
   end

  def add_link(url, title, tags = [])
		within ('#container') do 
			fill_in 'url', :with => url 
			fill_in 'title', :with => title 
		 	fill_in 'tags', :with => tags.join(' ')
			click_button 'Add link'
		end
	end	

  def time_gen 
    time = Time.now
    t = time.strftime("%T on %d-%m-%Y")
  end 

	
end