require 'bcrypt'

class User
	include DataMapper::Resource 

	attr_reader :password
	attr_accessor :password_confirmation

	property :id, Serial 
	property :email, String, :unique => true, :message => "This email is already taken" #this checks to see if the email is unique
	property :username, String, :unique => true, :message => "This username is already taken" 
	property :password_digest, Text #created column in db called 'password digest'
	property :password_token, Text 
	property :password_token_timestamp, DateTime
	has n, :links

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

  def generate_token 
  	self.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
		self.password_token_timestamp = Time.now
		self.save
	end

end
