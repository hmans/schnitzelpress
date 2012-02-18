module Schreihals
  module Actions
    module Blog
      extend ActiveSupport::Concern

      included do
        get '/' do
          # cache_for 5.minutes
          @posts = Post.latest.skip(params[:page].to_i * 10).limit(10)
          @show_description = true
          haml :index
        end

        get '/blog.css' do
          cache_for 1.hour
          scss :blog
        end

        get '/index.atom' do
          cache_for 3.minutes
          @posts = Post.latest.limit(10)
          content_type 'application/atom+xml; charset=utf-8'
          haml :atom, :format => :xhtml, :layout => false
        end

        get '/feed/?' do
          redirect settings.feed_url
        end

        get %r{^/(\d{4})/(\d{1,2})/?$} do
          year, month = params[:captures]
          @posts = Post.for_month(year.to_i, month.to_i)
          haml :index
        end

        get %r{^/(\d{4})/?$} do
          year = params[:captures].first
          @posts = Post.for_year(year.to_i)
          haml :index
        end

        get '/:year/:month/:day/:slug/?' do |year, month, day, slug|
          # cache_for 1.hour
          render_post(slug)
        end

        get '/:slug/?' do |slug|
          # cache_for 1.hour
          render_post(slug)
        end

        def render_post(slug)

          if @post = Post.where(slugs: slug).first
            # enforce canonical URL
            if request.path != url_for(@post)
              redirect url_for(@post)
            else
              haml :post
            end
          else
            halt 404
          end
        end
      end
    end
  end
end
