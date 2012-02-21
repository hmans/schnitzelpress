require 'schnitzelpress/version'

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

require 'schnitzelpress/app'

Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("../views", __FILE__))
Sass::Engine::DEFAULT_OPTIONS[:load_paths].unshift(File.expand_path("./views"))

Mongoid.logger.level = 3

module SchnitzelPress
  class MarkdownRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      CodeRay.highlight(code, language)
    end

    def autolink(link, type)
      OEmbed::Providers.get(link).html
    rescue OEmbed::NotFound
      %q(<a href="%s">%s</a>) % [link, link]
    end
  end

  mattr_reader :mongo_uri

  def self.mongo_uri=(uri)
    Mongoid::Config.from_hash("uri" => uri)
    SchnitzelPress::Post.create_indexes
    @@mongo_uri = uri
  end
end

# teach HAML to use RedCarpet for markdown
module Haml::Filters::Redcarpet
  include Haml::Filters::Base

  def render(text)
    Redcarpet::Markdown.new(SchnitzelPress::MarkdownRenderer,
      autolink: true, space_after_headers: true, fenced_code_blocks: true).
      render(text)
  end
end
