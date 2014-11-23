require 'sinatra/base'
require 'data_mapper'
require 'sinatra'

# class Chitter < Sinatra::Base
set :views, Proc.new{File.join(root,'..','views')}
env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require './lib/peep'
DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do 
	@peeps = Peep.all
	erb :index
end

 

 
#   run! if app_file == $0
# end
