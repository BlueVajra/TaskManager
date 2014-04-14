ENV['RACK_ENV'] = 'test'
require 'sequel'
require 'dotenv'
require_relative '../lib/task_repository'

Dotenv.load
DB = Sequel.connect(ENV['DATABASE_URL_TEST'])
TASKS = TaskRepository.new(DB)

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end



