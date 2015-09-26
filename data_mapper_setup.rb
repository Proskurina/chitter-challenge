require 'data_mapper'
require 'dm-validations'


env = ENV['RACK_ENV'] || 'development'

# we're telling datamapper to use a postgres database on localhost. The name will be "bookmark_manager_test" or "bookmark_manager_development" depending on the environment

if ENV['RACK_ENV'] == "production"
  DataMapper.setup(:default, ENV['DATABASE_URL'])
else
  DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")
end


# After declaring your models, you should finalise them
DataMapper.finalize

# However, the database tables don't exist yet. Let's tell datamapper to create them
DataMapper.auto_upgrade!
