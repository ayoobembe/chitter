
env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
require './lib/peep'
require './lib/maker'
DataMapper.finalize
DataMapper.auto_upgrade!