class Link
	include DataMapper::Resource 
	#like a module this gives us all the methods to interact with the database 


	property :id,	Serial 
	property :title, String 
	property :url, String 
	has n, :tags, :through => Resource

end


