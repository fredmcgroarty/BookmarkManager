require 'spec_helper'
require_relative 'helpers/session'
include SessionHelper

feature "registered user no longer has access to password" do 

  before(:each) do 
      User.create(
      :id => 1, 
      :email => 'test@example.com', 
      :password => 'test', 
      :password_confirmation => 'test')
  end

  scenario "and requests a retrieval token" do 
    visit ('/retrieve') 
		page.should have_css("#container_font", :text => "Enter Email Address")    
		fill_in :pass_retrieve, :with => "test@example.com"
		click_button 'Reset'
		expect(User.get(1).password_token).not_to be_nil
  end
end
