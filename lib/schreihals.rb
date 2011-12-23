require 'schreihals/version'
require 'sinatra'
require 'haml'
require 'sass'
require 'schnitzelstyle'
require 'document_mapper'

require 'active_support/core_ext/string/inflections'

module Schreihals
  class Post
    include DocumentMapper::Document
    self.directory = 'posts'

    def to_url
      "/posts/#{slug}/"
    end
  end

  class App < Sinatra::Application
    set :blog_title, "My Schreihals Blog"
    set :author_name, "Author"

    helpers do
      def partial(thing, options = {})
        type = thing.class.to_s.demodulize.underscore
        haml :"partials/_#{type}", :locals => { type.to_sym => thing }
      end

      def link_to(title, thing)
        url = thing.respond_to?(:to_url) ? thing.to_url : thing.to_s
        haml "%a{href: '#{url}'} #{title}"
      end
    end

    get '/' do
      @posts = Post.order_by(:date => :desc).all
      haml :index
    end

    get '/posts/:slug/?' do |slug|
      if @post = Post.where(:slug => slug).first
        haml :post
      else
        "not found :("
      end
    end

    get '/schreihals.css' do
      scss :schreihals
    end
  end
end
