require 'bcrypt'
class Maker
	include DataMapper::Resource

	attr_reader :password 
	attr_accessor :password_digest
	validates_confirmation_of :password 
	validates_uniqueness_of :email


	property :id, Serial
	property :email, String, :unique => true, :message =>"This email is taken"
	property :password_digest, Text

	def password=(password)
		self.password_digest = BCrypt::Password.create(password)
	end

end