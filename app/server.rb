require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'debugger'
require 'sinatra/partial'

require_relative './models/link'
require_relative './models/tag'
require_relative './models/user'

require_relative 'controllers/links'
require_relative 'controllers/sessions'
require_relative 'controllers/users'
require_relative 'controllers/tags'
require_relative 'controllers/recovery'

require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions 
set :session_secret, 'xxx222kkk'
set :partial_template_engine, :erb
use Rack::Flash

