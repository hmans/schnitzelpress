module Schnitzelpress
  class App < Sinatra::Base
    STATIC_PATHS = ["/favicon.ico", "/img", "/js"]

    set :views, ['./views/', File.expand_path('../../views/', __FILE__)]
    set :public_folder, File.expand_path('../../public/', __FILE__)

    use Rack::ShowExceptions
    use Rack::StaticCache,
      :urls => STATIC_PATHS,
      :root => File.expand_path('../../public/', __FILE__)
    use Rack::MethodOverride
    use Rack::Session::Cookie

    helpers Schnitzelpress::Helpers
    include Rack::Utils
    include Schnitzelpress::Actions::Auth
    include Schnitzelpress::Actions::Assets
    include Schnitzelpress::Actions::Admin
    include Schnitzelpress::Actions::Blog

    configure do
      set :blog_title, "My Schnitzelpress Blog"
      set :blog_description, ""
      set :author_name, "Author"
      set :disqus_name, nil
      set :google_analytics_id, nil
      set :gauges_id, nil
      set :read_more, "Read Complete Article"
      set :twitter_id, nil
      set :footer, ""
      set :administrator, nil
      set :feed_url, '/blog.atom'

      disable :protection
      set :logging, true
    end

    def fresh_when(options)
      last_modified options[:last_modified]
      etag options[:etag]
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
