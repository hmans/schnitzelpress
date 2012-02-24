module SchnitzelPress
  class App < Sinatra::Base
    set :views, ['./views/', File.expand_path('../../views/', __FILE__)]
    set :public_folder, File.expand_path('../../public/', __FILE__)

    use SchnitzelPress::Static
    use Rack::ShowExceptions
    use Rack::Cache
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
      cache_control :public, :must_revalidate, max_age: time.to_i
    end

    not_found do
      haml :"404"
    end
  end
end
