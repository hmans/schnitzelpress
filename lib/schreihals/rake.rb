task :environment do
  require 'schreihals'
end

desc 'Run the Schreihals console'
task :console => :environment do
  require 'irb'
  require 'wirble'
  ARGV.clear
  Wirble.init
  Wirble.colorize
  IRB.start
end
