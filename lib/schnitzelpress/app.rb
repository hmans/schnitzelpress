module SchnitzelPress
  class App < Sinatra::Base
    STATIC_PATHS = ["/favicon.ico", "/img", "/js", '/moo.txt']

    set :views, ['./views/', File.expand_path('../../views/', __FILE__)]
    set :public_folder, File.expand_path('../../public/', __FILE__)

    use Rack::ShowExceptions
    use Rack::StaticCache,
      :urls => STATIC_PATHS,
      :root => File.expand_path('../../public/', __FILE__)
    use Rack::MethodOverride
    use Rack::Session::Cookie

    helpers SchnitzelPress::Helpers
    include Rack::Utils
    include SchnitzelPress::Actions::Auth
    include SchnitzelPress::Actions::Admin
    include SchnitzelPress::Actions::Blog

    configure do
      set :blog_title, "My SchnitzelPress Blog"
      set :blog_description, ""
      set :author_name, "Author"
      set :disqus_name, nil
      set :google_analytics_id, nil
      set :gauges_id, nil
      set :read_more, "Read Complete Article"
      set :twitter_id, nil
      set :footer, ""
      set :administrator, nil
      set :feed_url, '/posts.atom'

      disable :protection
      set :logging, true
    end

    def cache_for(time)
      cache_control :public, :must_revalidate, :max_age => time.to_i
    end

    not_found do
      haml :"404"
    end

    def self.with_local_files
      Rack::Cascade.new([
        Rack::StaticCache.new(self, :urls => STATIC_PATHS, :root => './public'),
        self
      ])
    end
  end
end
