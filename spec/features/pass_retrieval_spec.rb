require 'spec_helper'
require_relative 'helpers/session'
include SessionHelper

feature "registered user no longer has access to password" do 

  before(:each) do 
      User.create(
      :id => 1, 
      :email => 'test@example.com', 
      :password => 'test', 
      :password_confirmation => 'test', 
      :password_token => 'RESET_TOKEN', 
      :password_token_timestamp => Time.now)
  end

  scenario "and requests a retrieval token" do 
    visit ('/retrieve') 
		page.should have_css("#container_font", :text => "Enter Email Address")    
		fill_in :pass_retrieve, :with => "test@test.com"
    User.any_instance.stub(:generate_password_token).and_return(true)
  end
end
