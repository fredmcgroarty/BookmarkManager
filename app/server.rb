require 'sinatra'
require 'data_mapper'
require 'rack-flash'

require './lib/link'
require './lib/tag'
require './lib/user'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions 
set :session_secret, 'xxx222kkk'
use Rack::Flash

	get '/' do
	  @links = Link.all
	  erb :index
	end
	
	post '/links' do 
		url = params["url"]
		title = params["title"]
		tags = params["tags"].split(" ").map do |tag|
    	Tag.first_or_create(:text => tag)
  	end
		Link.create(:url => url, :title => title, :tags => tags)
		redirect to('/')
	end

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
  		session[:user_id] = @user.id #this adds all the inputted information if successful and the session can proceed
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




  


