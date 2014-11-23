require 'sinatra/base'
require 'data_mapper'
require 'sinatra'

# class Chitter < Sinatra::Base
set :views, Proc.new{File.join(root,'..','views')}
env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require './lib/peep'
require './lib/maker'
DataMapper.finalize
DataMapper.auto_upgrade!

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
	# @user = User.new
	erb :"makers/new"
end

post '/makers' do 
	@maker = Maker.create(:email => params[:email],
							:password => params[:password],
							:password_confirmation => params[:password_confirmation])
	# p @maker 
	session[:maker_id] = @maker.id
	# p session 
	redirect to('/')
end

 

 
#   run! if app_file == $0
# end
