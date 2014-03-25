require 'data_mapper'
env = ENV["RACK_ENV"] || "development" #indicating the default envrionment to work in

DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
#selecting the database based on the envrionment 

require './lib/link'

DataMapper.finalize

DataMapper.auto_upgrade!