require_relative 'app'
require 'sequel'
require_relative 'lib/task_repository'
require 'dotenv'

Dotenv.load
DB = Sequel.connect(ENV['DATABASE_URL'])
TASKS = TaskRepository.new(DB)
run App