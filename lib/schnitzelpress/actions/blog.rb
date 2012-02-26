module SchnitzelPress
  module Actions
    module Blog
      extend ActiveSupport::Concern

      included do
        get '/' do
          @show_description = true
          if @post = Post.published.pages.where(:slugs => 'home').first
            extra_posts = Post.latest.limit(5)
            @extra_posts = ['From the Blog:', extra_posts] if extra_posts.any?
            render_post
          else
            render_blog
          end
        end

        get '/blog/?' do
          @show_description = true
          render_blog
        end

        def render_blog
          total_count   = Post.latest.count
          skipped_count = params[:page].to_i * 10
          @posts = Post.latest.skip(skipped_count).limit(10)

          displayed_count = @posts.count(true)
          @show_previous_posts_button = total_count > skipped_count + displayed_count

          render_posts
        end

        get '/blog.css' do
          cache_for 1.hour
          scss :blog
        end

        # /posts.atom is now deprecated.
        get '/posts.atom' do
          redirect '/blog.atom', 301
        end

        get '/blog.atom' do
          cache_for 3.minutes
          @posts = Post.latest.limit(10)
          content_type 'application/atom+xml; charset=utf-8'
          haml :atom, :format => :xhtml, :layout => false
        end

        get '/feed/?' do
          redirect settings.feed_url, 307
        end

        get %r{^/(\d{4})/(\d{1,2})/(\d{1,2})/?$} do
          year, month, day = params[:captures]
          @posts = Post.latest.for_day(year.to_i, month.to_i, day.to_i)
          render_posts
        end

        get %r{^/(\d{4})/(\d{1,2})/?$} do
          year, month = params[:captures]
          @posts = Post.latest.for_month(year.to_i, month.to_i)
          render_posts
        end

        get %r{^/(\d{4})/?$} do
          year = params[:captures].first
          @posts = Post.latest.for_year(year.to_i)
          render_posts
        end

        get '/:year/:month/:day/:slug/?' do |year, month, day, slug|
          @post = Post.
            for_day(year.to_i, month.to_i, day.to_i).
            where(:slugs => slug).first

          render_post
        end

        get '/*/?' do
          slug = params[:splat].first
          @post = Post.where(:slugs => slug).first
          render_post
        end

        def render_post(enforce_canonical_url = true)
          if @post
            # enforce canonical URL
            if enforce_canonical_url && request.path != url_for(@post)
              redirect url_for(@post)
            else
              fresh_when :last_modified => @post.updated_at, :etag => @post.to_etag
              cache_for 60

              @show_description = @post.home_page?
              haml :post
            end
          else
            halt 404
          end
        end

        def render_posts
          if freshest_post = @posts.where(:updated_at.ne => nil).desc(:updated_at).first
            fresh_when :last_modified => freshest_post.updated_at,
              :etag => freshest_post.to_etag
            cache_for 60
          end

          haml :index
        end
      end
    end
  end
end
