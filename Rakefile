namespace :db do
  task :sequel do
    begin
      require 'dotenv'
      Dotenv.load
    rescue LoadError
    end
    require "sequel"
    Sequel.extension :migration
    DB = Sequel.connect(ENV['DATABASE_URL'])
  end

  desc "Prints current schema version"
  task :version => :sequel do
    version = if DB.tables.include?(:schema_info)
                DB[:schema_info].first[:version]
              end || 0

    puts "Schema Version: #{version}"
  end

  desc "Perform migration up to latest migration available"
  task :migrate => :sequel do
    Sequel::Migrator.run(DB, "migrations")
    Rake::Task['db:version'].execute
  end
end

namespace :db_test do
  task :sequel do
    begin
      require 'dotenv'
      Dotenv.load
    rescue LoadError
    end
    require "sequel"
    Sequel.extension :migration
    DBT = Sequel.connect(ENV['DATABASE_URL_TEST'])
  end

  desc "Prints current schema version"
  task :version => :sequel do
    version = if DBT.tables.include?(:schema_info)
                DBT[:schema_info].first[:version]
              end || 0

    puts "Schema Version: #{version}"
  end

  desc "Perform migration up to latest migration available"
  task :migrate => :sequel do
    Sequel::Migrator.run(DBT, "migrations")
    Rake::Task['db_test:version'].execute
  end
end