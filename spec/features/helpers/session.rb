module SessionHelper

  def sign_in(email, password)
    visit '/sessions/new' 
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    click_button 'Sign in'
  end

  def sign_up(email = "alice@example.com", 
              password = "oranges!",
              password_confirmation = "oranges!")
    visit '/users/new'
    fill_in :email, :with => email
    fill_in :password, :with => password
    fill_in :password_confirmation, :with => password_confirmation
    click_button "Sign up"
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