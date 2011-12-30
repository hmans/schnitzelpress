require 'rubygems'
require 'bundler/setup'
require 'riot'

$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'schreihals'

require 'rack/test'
set :environment, :test
