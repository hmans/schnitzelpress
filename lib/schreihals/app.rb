require 'schreihals/static'
require 'schreihals/helpers'
require 'schreihals/post'
require 'schreihals/actions/blog'
require 'schreihals/actions/auth'
require 'schreihals/actions/admin'

module Schreihals
  class App < Sinatra::Base
    set :views, ['./views/', File.expand_path('../../views/', __FILE__)]
    set :public_folder, File.expand_path('../../public/', __FILE__)

    use Schreihals::Static
    use Rack::ShowExceptions
    use Rack::Cache
    use Rack::Session::Cookie

    helpers Schreihals::Helpers
    include Schreihals::Actions::Auth
    include Schreihals::Actions::Admin
    include Schreihals::Actions::Blog

    configure do
      set :blog_title, "My Schreihals Blog"
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

    not_found do
      haml :"404"
    end
  end
end
