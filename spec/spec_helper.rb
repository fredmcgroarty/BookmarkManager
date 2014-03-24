ENV["RACK_ENV"] = 'test'

#using the right database for tests

require 'server' 
require 'database_cleaner' #required so the database is cleaned after every test 

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
  
end
