module Schnitzelpress
  module Actions
    module Admin
      extend ActiveSupport::Concern

      included do
        before '/admin/?*' do
          admin_only!
        end

        get '/admin/?' do
          @posts  = Post.published.posts.desc(:published_at)
          @pages  = Post.published.pages
          @drafts = Post.drafts
          haml :'admin/admin'
        end

        get '/admin/new/?' do
          @post = Post.new
          haml :'admin/new'
        end

        post '/admin/new/?' do
          @post = Post.new(params[:post])
          if @post.save
            redirect url_for(@post)
          else
            haml :'admin/new'
          end
        end

        get '/admin/edit/:id/?' do
          @post = Post.find(params[:id])
          haml :'admin/edit'
        end

        put '/admin/edit/:id/?' do
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
