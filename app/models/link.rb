class Link
	include DataMapper::Resource 

	property :id,	Serial 
	property :title, String 
	property :url, String 
	property :time, DateTime
	property :description, String, :default => "A description has not been added"
	property :favourite, Boolean, :default => false
	
	has n, :tags, :through => Resource
	belongs_to :user 


end


