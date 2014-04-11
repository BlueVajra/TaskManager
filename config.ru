require_relative 'app'
require 'sequel'
require 'dotenv'

Dotenv.load
DB = Sequel.connect(ENV['DATABASE_URL'])

run App