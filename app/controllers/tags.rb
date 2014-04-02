
	get '/tags/:text' do 
		tag = Tag.first(:text => params[:text])
		user_email = current_user.email

		@links = tag ? tag.links : [] 
		erb :index
	end
  # this will either find this tag or create
  # it if it doesn't exist already