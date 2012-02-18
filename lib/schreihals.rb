require 'schreihals/version'

require 'sinatra'
require 'haml'
require 'sass'
require 'redcarpet'
require 'schnitzelstyle'
require 'rack-cache'
require 'mongoid'
require 'chronic'

require 'active_support/inflector'
require 'active_support/core_ext/class'
require 'active_support/concern'

require 'schreihals/app'

Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("../views", __FILE__))
Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("./views"))

Mongoid.logger.level = 3

module Schreihals
  mattr_reader :mongo_uri

  def self.mongo_uri=(uri)
    Mongoid::Config.from_hash("uri" => uri)
    @@mongo_uri = uri
  end
end
