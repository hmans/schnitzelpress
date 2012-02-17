SPEC_DIR = File.dirname(__FILE__)
lib_path = File.expand_path("#{SPEC_DIR}/../lib")
$LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require 'rubygems'
require 'bundler/setup'

require 'schreihals'

Schreihals.mongo_uri = 'mongodb://localhost/_schreihals_test'

require 'awesome_print'
require 'rack/test'
require 'rspec-html-matchers'
require 'database_cleaner'
require 'factory_girl'
require File.expand_path("../factories.rb", __FILE__)
require 'timecop'
Timecop.freeze

set :environment, :test

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner[:mongoid].start
  end

  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end
end
