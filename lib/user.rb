require 'bcrypt'

class User
	include DataMapper::Resource 

	attr_reader :password
	#makes the password variable publically available for get
	attr_accessor :password_confirmation
	#makes the password_confirmation variable publically available for get and set
	property :id, Serial 
	property :email, String, :unique => true, :message => "This email is already taken" #this checks to see if the email is unique 
	property :password_digest, Text #created column in db called 'password digest'

	def password=(password)
		#creating a setter method (takes a password and sets the password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end 

  validates_confirmation_of :password, :message => "Sorry, your passwords don't match"
  #without the message, datamaper includes an autoresponse 

  def self.authenticate(email, password)
    user = first(:email => email)
    if user && BCrypt::Password.new(user.password_digest) == password
      user
    else
      nil
    end
  end

end
