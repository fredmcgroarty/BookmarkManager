require 'spec_helper'

feature "user signs up" do 

	scenario "when signing up" do 
		lambda { sign_up }.should change(User, :count).by(1)    
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")        
  end

  def sign_up(email = "alice@example.com", 
              password = "oranges!")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    click_button "Sign up"
  end

end
