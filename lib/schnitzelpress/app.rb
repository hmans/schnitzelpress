module Schnitzelpress
  class App < Sinatra::Base
    STATIC_PATHS = ["/favicon.ico", "/img", "/js"]

    set :views, ['./views/', File.expand_path('../../views/', __FILE__)]
    set :public_folder, File.expand_path('../../public/', __FILE__)

    use Rack::Cache if Schnitzelpress.env.production?
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
      disable :protection
      set :logging, true
    end

    before do
      # Reload configuration before every request. I know this isn't ideal,
      # but right now it's the easiest way to get the configuration in synch
      # across multiple instances of the app.
      #
      Config.instance.reload unless Config.instance.new_record?
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
