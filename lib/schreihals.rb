require 'schreihals/version'

require 'sinatra'
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

require 'omniauth'
require 'omniauth-browserid'

require 'schreihals/static'
require 'schreihals/helpers'
require 'schreihals/post'
require 'schreihals/actions'
require 'schreihals/admin_actions'
require 'schreihals/app'

Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("../views", __FILE__))
Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("./views"))

module Schreihals
end
