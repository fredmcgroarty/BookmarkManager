require 'bcrypt'

class User

	attr_reader :password
	#makes the password variable publically available for get
	attr_accessor :password_confirmation
	#makes the password_confirmation variable publically available for get and set

	include DataMapper::Resource 

	property :id, Serial 
	property :email, String, :unique => true #this checks to see if the email is unique 
	property :password_digest, Text #created column in db called 'password digest'

	def password=(password)
		#creating a setter method (takes a password and sets the password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end 

  validates_confirmation_of :password

end
