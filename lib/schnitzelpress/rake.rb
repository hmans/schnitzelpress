require 'schnitzelpress'

desc 'Run the SchnitzelPress console'
task :console do
  require 'pry'
  ARGV.clear
  pry
end

namespace :db do
  desc 'Import Heroku database to local database'
  task :pull do
    system "MONGO_URL=\"#{SchnitzelPress.mongo_uri}\" heroku mongo:pull"
  end

  desc 'Push local database to Heroku'
  task :push do
    system "MONGO_URL=\"#{SchnitzelPress.mongo_uri}\" heroku mongo:push"
  end
end
