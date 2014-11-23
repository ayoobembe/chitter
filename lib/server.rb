require 'sinatra/base'
require 'data_mapper'
require 'sinatra'
require 'rack-flash'

# class Chitter < Sinatra::Base
set :views, Proc.new{File.join(root,'..','views')}
env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require './lib/peep'
require './lib/maker'
DataMapper.finalize
DataMapper.auto_upgrade!

use Rack::Flash

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
		flash[:notice] = "Sorry, your passwords don't match"
		erb :"makers/new"
	end
end

 

 
  # run! if app_file == $0
# end
