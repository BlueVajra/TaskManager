require_relative 'app'
require 'sequel'
require_relative 'lib/task_repository'
require_relative 'lib/project_repository'

require 'dotenv'

Dotenv.load
DB = Sequel.connect(ENV['DATABASE_URL'])
Sequel::Model.db = DB

require_relative 'lib/model_repository'


run App