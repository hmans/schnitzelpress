require 'schnitzelpress/version'

require 'sinatra'
require 'haml'
require 'sass'
require 'redcarpet'
require 'schnitzelstyle'
require 'rack/contrib'
require 'mongoid'
require 'chronic'

require 'active_support/inflector'
require 'active_support/core_ext/class'
require 'active_support/concern'

require 'schnitzelpress/env'
require 'schnitzelpress/static'
require 'schnitzelpress/helpers'
require 'schnitzelpress/markdown_renderer'
require 'schnitzelpress/post'
require 'schnitzelpress/actions/assets'
require 'schnitzelpress/actions/blog'
require 'schnitzelpress/actions/auth'
require 'schnitzelpress/actions/admin'
require 'schnitzelpress/app'

Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("../views", __FILE__))
Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("./views"))

Mongoid.logger.level = 3

module Schnitzelpress
  mattr_reader :mongo_uri

  class << self
    def mongo_uri=(uri)
      Mongoid::Config.from_hash("uri" => uri)
      Schnitzelpress::Post.create_indexes
      @@mongo_uri = uri
    end
  end
end

# teach HAML to use RedCarpet for markdown
module Haml::Filters::Redcarpet
  include Haml::Filters::Base

  def render(text)
    Redcarpet::Markdown.new(Schnitzelpress::MarkdownRenderer,
      :autolink => true, :space_after_headers => true, :fenced_code_blocks => true).
      render(text)
  end
end
