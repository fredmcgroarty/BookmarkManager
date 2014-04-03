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
		description = params["description"]
		tags = params["tags"].split(" ").map do |tag|
    	Tag.first_or_create(:text => tag)
  	end
		link = Link.new(:url => url, :title => title, :tags => tags, :time => time, :description => description)
		link.user = current_user
		link.save
		redirect to('/')
	end
