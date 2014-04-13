# Basic Task App - Skeleton

this is a skeleton app with basic setup. Sinatra with Postgres. Includes:
- dotenv, for ENV storage
- sql script, for easy table setup
- Rakefile, for migrations

## Local Setup

1. `bundle`
1. Create `.env`
  - `touch .env`
1. Add your correct username and password in the connection string in `.env`
  - `DATABASE_URL = 'postgres://gschool_user:password@localhost/tasks_database'`
  - `DATABASE_URL_TEST = 'postgres://gschool_user:password@localhost/tasks_database_test'`
1. Change User info in `scripts/create_database.sql'
1. Create Databases
  1. Run create database script:
    - `psql -d postgres -f scripts/create_database.sql`
    - or
  1. Create databases manually:
    - `createdb -U gschool_user tasks_database`
    - `createdb -U gschool_user tasks_database_test`
1. Migrate the db
  1. main DB via Rakefile
    - `rake db:migrate`
  2. test DB via Rakefile
    - `rake db_test:migrate`
  1. test both manually
    - `sequel -m migrations postgres://user:password@localhost/task_manager_test`
    - `sequel -m migrations postgres://user:password@localhost/task_manager`
1. Rock and Roll
  - `rspec`
  - `rackup`

## Deployment

1. `git push <heroku app name> master`
1. `heroku run rake db:migrate -a <heroku app name>`
1. `heroku restart -a <heroku app name>`

Alternately, you can run migrations with:

```bash
heroku run 'sequel -m migrations $DATABASE_URL' --app <heroku app name>
```

## Running Specs

1. `rspec`

