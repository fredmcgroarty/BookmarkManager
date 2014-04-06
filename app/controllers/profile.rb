get '/profile/:username' do
  user = User.first(:username => params[:username]) 
  @links = user ? user.links : []
  erb :"users/profile"
end