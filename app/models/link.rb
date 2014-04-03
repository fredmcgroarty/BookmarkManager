class Link
	include DataMapper::Resource 
	#like a module this gives us all the methods to interact with the database 
	property :id,	Serial 
	property :title, String 
	property :url, String 
	#needs to change to time now, giving test issues.
	property :time, DateTime
	property :description, String
	property :favourite, Boolean, :default => false
	
	has n, :tags, :through => Resource
	belongs_to :user


end


