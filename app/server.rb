require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'debugger'
require 'sinatra/partial'

require './lib/link'
require './lib/tag'
require './lib/user'

require_relative 'controllers/links'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions 
set :session_secret, 'xxx222kkk'
set :partial_template_engine, :erb
use Rack::Flash



	get '/tags/:text' do 
		tag = Tag.first(:text => params[:text])
		@links = tag ? tag.links : [] 
		erb :index
	end
  # this will either find this tag or create
  # it if it doesn't exist already

  get '/users/new' do
  	@user = User.new  
  	erb :"users/new" 
  	#in speech marks because otherwise it'd think its a sum
  end

  post '/users' do
  	@user = User.new(:email => params[:email],
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

	get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do 
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password is incorrect"]
      erb :"sessions/new"
    end
  end

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

  delete '/sessions' do
    flash[:notice] = "Adios!"
    session[:user_id] = nil
    redirect to('/')
  end



  




  


