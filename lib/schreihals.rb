require 'schreihals/version'

require 'sinatra'
require 'haml'
require 'sass'
require 'redcarpet'
require 'schnitzelstyle'
require 'rack-cache'
require 'mongoid'

require 'active_support/inflector'
require 'active_support/core_ext/class'
require 'active_support/concern'

require 'schreihals/app'

require 'rubypython'
RubyPython.configure :python_exe => 'python2.6'

Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("../views", __FILE__))
Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("./views"))

module Schreihals
end
