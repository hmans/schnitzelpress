require 'schreihals'

desc 'Run the Schreihals console'
task :console do
  require 'irb'
  require 'wirble'
  ARGV.clear
  Wirble.init
  Wirble.colorize
  IRB.start
end

namespace :db do
  desc 'Import Heroku database to local database'
  task :pull do
    system 'MONGO_URL="mongodb://localhost/schreihals" heroku mongo:pull'
  end

  task :push do
  end
end
