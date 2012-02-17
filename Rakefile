#!/usr/bin/env rake
require "bundler/gem_tasks"

# integrate riot
require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/*_test.rb'
  test.verbose = true
end

# console
require 'wirble'

task :environment do
  require './lib/schreihals'
end

desc 'Run the Pants console'
task :console => :environment do
  require 'irb'
  ARGV.clear
  Wirble.init
  Wirble.colorize
  IRB.start
end


task :default => :test
