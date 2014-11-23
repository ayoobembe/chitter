require 'bcrypt'
class Maker
	include DataMapper::Resource

	attr_reader :password 
	attr_accessor :password_confirmation
	validates_confirmation_of :password 
	validates_uniqueness_of :email


	property :id, Serial
	property :email, String, :unique => true, :message =>"This email is taken"
	property :password_digest, Text
	property :password_token, Text
	property :password_token_time_stamp, Time 

	def password=(password)
		@password = password 
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email,password) 
		maker = first(:email => email)
		if maker && BCrypt::Password.new(maker.password_digest)==password 
			maker
		else
			nil
		end
	end


end