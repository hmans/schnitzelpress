require 'schnitzelpress/version'

require 'sinatra'
require 'haml'
require 'sass'
require 'redcarpet'
require 'liquid'
require 'schnitzelstyle'
require 'rack/contrib'
require 'rack/cache'
require 'mongoid'
require 'chronic'

require 'active_support/inflector'
require 'active_support/core_ext/class'
require 'active_support/concern'

require 'schnitzelpress/cache_control'
require 'schnitzelpress/env'
require 'schnitzelpress/drops'
require 'schnitzelpress/static'
require 'schnitzelpress/helpers'
require 'schnitzelpress/markdown_renderer'
require 'schnitzelpress/config'
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

    def init!
      # Mongoid.load!("./config/mongo.yml")
      if mongo_uri = ENV['MONGOLAB_URI'] || ENV['MONGOHQ_URL'] || ENV['MONGO_URL']
        self.mongo_uri = mongo_uri
      else
        raise "Please set MONGO_URL, MONGOHQ_URL or MONGOLAB_URI to your MongoDB connection string."
      end
      Schnitzelpress::Post.create_indexes
    end

    def omnomnom!
      init!
      App.with_local_files
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
