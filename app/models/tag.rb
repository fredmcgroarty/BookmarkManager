class Tag

  include DataMapper::Resource

  has n, :links, :through => Resource
  has 1, :user, :through => Resource

  property :id, Serial
  property :text, String
  
end
