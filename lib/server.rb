require 'sinatra/base'
require 'data_mapper'

# class Chitter < Sinatra::Base

env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require './lib/peep'
DataMapper.finalize
DataMapper.auto_upgrade!

 

 
#   run! if app_file == $0
# end
