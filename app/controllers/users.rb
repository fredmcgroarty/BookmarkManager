get '/users/new' do
    @user = User.new  
    erb :"users/new" 
    #in speech marks because otherwise it'd think its a sum
  end

  post '/users' do
    @user = User.new(:email => params[:email],
                     :username => params[:username],
                     :password => params[:password],
                     :password_confirmation => params[:password_confirmation])  
    if @user.save
      user_id = :user_id
      session[user_id] = @user.id #this adds all the inputted information if successful and the session can proceed
      redirect to('/')
    else 
      flash.now[:errors] = @user.errors.full_messages #if there is an error (i.e) passwords don't match, then the data stored in the @user object will be redirected with the error messages onto the new page 
      erb :"users/new"
    end
  end
