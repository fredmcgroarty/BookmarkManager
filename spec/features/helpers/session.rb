module SessionHelper

  def sign_in(email, password)
    visit '/sessions/new' #why do we sign in at sessions/new and not /sign_in /login or something like that. When signing in/out we are manipulating a session : creating ti, destroying it and displaying a form to create it 
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

end