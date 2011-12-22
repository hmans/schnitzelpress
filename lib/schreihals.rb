require 'schreihals/version'
require 'sinatra'
require 'document_mapper'

module Schreihals
  class Post
    include DocumentMapper::Document
    self.directory = 'posts'
  end

  class App < Sinatra::Application
    set :blog_title, "My Schreihals Blog"
    set :author_name, "Author"

    get '/' do
      @posts = Post.all
      haml :index
    end

    get '/posts/:slug/?' do |slug|
      if @post = Post.where(:slug => slug).first
        haml :post
      else
        "not found :("
      end
    end
  end
end
