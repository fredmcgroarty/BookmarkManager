  get '/retrieve' do 
    erb :"users/retrieve"
  end

  post '/recovery' do
    email = params[:pass_retrieve]
    user = User.first(:email => email)
    if user
      user.generate_token
    end 
    flash[:notice] = "An email will be with you shortly"
    redirect to('/')
  end
