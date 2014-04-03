get '/profile' do
  user = User.first(:id => params[:id]) 
  @links = user ? user.links : []
  erb :"users/profile"
end