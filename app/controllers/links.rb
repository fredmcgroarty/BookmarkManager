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
		time = Time.now
		instance = time.strftime("%Y-%m-%d %T")
		tags = params["tags"].split(" ").map do |tag|
    	Tag.first_or_create(:text => tag)
  	end
		Link.create(:url => url, :title => title, :tags => tags, :instance => instance)
		redirect to('/')
	end
