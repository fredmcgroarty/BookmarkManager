require 'bcrypt'

class User

	include DataMapper::Resource 

	property :id, Serial 
	property :email, String
	property :password_digest, Text #created column in db called 'password digest'

	def password=(password)
		#creating a setter method (takes a password and sets the password)
		self.password_digest = BCrypt::Password.create(password)
	end 

end
