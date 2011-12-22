require 'schreihals/version'
require 'sinatra'
require 'document_mapper'

module Schreihals

  class App < Sinatra::Application
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

  # class App < Renee::Application
  #   app {
  #     path('/').get.foo!
  #     path('posts') do
  #       var do |slug|
  #         if post = Post.where(:slug => slug).first
  #           halt post.title
  #         else
  #           halt "not found :("
  #         end
  #       end
  #     end
  #   }.setup {
  #     views_path "#{Gem.loaded_specs['schreihals'].full_gem_path}/views"
  #   }

  #   def foo!
  #     render! "index.haml" #view, :layout => "layouts/app", :locals => {:title_part => title }
  #   end

  #   def show_post!
  #     var :string do |slug|
  #       halt "post! #{slug}"
  #     end
  #   end
  # end

  class Post
    include DocumentMapper::Document
    self.directory = 'posts'
  end
end
