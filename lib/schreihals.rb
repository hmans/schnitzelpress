require 'schreihals/version'

require 'sinatra'
require 'sinatra/namespace'
require 'haml'
require 'sass'
require 'redcarpet'
require 'schnitzelstyle'
require 'rack-cache'
require 'coderay'
require 'rack/codehighlighter'
require 'mongoid'

require 'active_support/inflector'
require 'active_support/core_ext/class'
require 'active_support/concern'

require 'schreihals/static'
require 'schreihals/helpers'
require 'schreihals/post'
require 'schreihals/actions'
require 'schreihals/admin_actions'
require 'schreihals/app'

Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("../views", __FILE__))
Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("./views"))

# configure mongoid
Mongoid::Config.from_hash(
  "uri" => ENV['MONGOLAB_URI'] || ENV['MONGOHQ_URL'] || ENV['MONGO_URL'] || 'mongodb://localhost/schreihals'
)

module Schreihals
end
