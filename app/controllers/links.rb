get '/' do
  @links = Link.all
  erb :"index"
end
get '/links/new' do
	erb :"links/new"
end

post '/links' do 
		url = params["url"]
		title = params["title"]
		time = Time.now.strftime("%T on %d-%m-%Y")
		user_email = current_user.email
		tags = params["tags"].split(" ").map do |tag|
    	Tag.first_or_create(:text => tag)
  	end
		Link.create(:url => url, :title => title, :tags => tags, :time => time, :user_email => user_email)
		redirect to('/')
	end
