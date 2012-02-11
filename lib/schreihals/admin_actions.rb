module Schreihals
  module AdminActions
    extend ActiveSupport::Concern

    included do
      namespace '/admin' do
        get '/?' do
          @posts = Post.desc(:published_at)
          haml :'admin/admin'
        end

        get '/new/?' do
          @post = Post.new
          haml :'admin/new'
        end

        post '/new/?' do
          @post = Post.new(params[:post])
          if @post.save
            redirect url_for(@post)
          else
            haml :'admin/new'
          end
        end

        get '/edit/:id/?' do
          @post = Post.find(params[:id])
          haml :'admin/edit'
        end

        post '/edit/:id/?' do
          @post = Post.find(params[:id])
          @post.attributes = params[:post]
          if @post.save
            redirect url_for(@post)
          else
            haml :'admin/edit'
          end
        end
      end
    end
  end
end
