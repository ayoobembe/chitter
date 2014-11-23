require 'sinatra/base'
require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require './lib/data_mapper_setup'

# class Chitter < Sinatra::Base
set :views, Proc.new{File.join(root,'..','views')}
use Rack::Flash
use Rack::MethodOverride
enable :sessions
set :session_secret, 'super secret'

helpers do 
	def current_maker
		@current_maker ||= Maker.get(session[:maker_id]) if session[:maker_id]
	end
end

get '/' do 
	@peeps = Peep.all
	erb :index
end

post '/peeps' do 
	text = params[:text]
	Peep.create(:text => text)
	redirect to('/')
end

get '/makers/new' do 
	@maker = Maker.new
	erb :"makers/new"
end

post '/makers' do 
	@maker = Maker.new(:email => params[:email],
							:password => params[:password],
							:password_confirmation => params[:password_confirmation])
	# p @maker 
	if @maker.save
		session[:maker_id] = @maker.id
		redirect to('/')
	else 
		flash.now[:errors] = @maker.errors.full_messages
		erb :"makers/new"
	end
end

get '/sessions/new' do 
	erb :"/sessions/new"
end

post '/sessions' do 
	email, password = params[:email], params[:password]
	maker = Maker.authenticate(email, password)
	if maker 
		session[:maker_id] = maker.id
		redirect to('/')
	else
		flash[:errors] = ['The email of password is incorrect']
		erb :"/sessions/new"
	end
end

delete '/sessions' do 
	session.delete(:maker_id)
	erb :"sessions/new"
end
 

 
#   run! if app_file == $0
# end
