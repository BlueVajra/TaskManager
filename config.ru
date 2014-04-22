require_relative 'app'
require 'sequel'

require 'dotenv'

Dotenv.load
DB = Sequel.connect(ENV['DATABASE_URL'])
Sequel::Model.db = DB

require_relative 'lib/model_repository'


run App