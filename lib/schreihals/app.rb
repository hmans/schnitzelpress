module Schreihals
  class App < Sinatra::Base
    set :views, ['./views/', File.expand_path('../../views/', __FILE__)]
    set :public_folder, File.expand_path('../../public/', __FILE__)

    use Schreihals::Static
    use Rack::ShowExceptions
    use Rack::Cache
    use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*\n/

    use Rack::Session::Cookie
    #use OmniAuth::Strategies::Developer
    use OmniAuth::Strategies::BrowserID

    helpers Schreihals::Helpers
    include Schreihals::AdminActions
    include Schreihals::Actions

    configure do
      set :blog_title, "My Schreihals Blog"
      set :blog_url, ""
      set :blog_description, ""
      set :author_name, "Author"
      set :disqus_name, nil
      set :google_analytics_id, nil
      set :gauges_id, nil
      set :read_more, "Read Complete Article"
      set :twitter_id, nil
      set :footer, ""
      set :administrator, nil
    end

    def admin_only!
      redirect '/login' unless admin_logged_in?
    end

    def cache_for(time)
      cache_control :public, :must_revalidate, :max_age => time.to_i
    end

    def render_page(slug)
      if @post = Post.where(slugs: slug).first
        haml :post
      else
        halt 404
      end
    end

    def absolutionize(url)
      if should_absolutionize?(url)
        "#{base_url}#{url}"
      else
        url
      end
    end

    def should_absolutionize?(url)
      url && url[0] == '/'
    end

    def base_url
      "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}"
    end

    not_found do
      haml :"404"
    end
  end
end
