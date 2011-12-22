require "schreihals/version"

module Schreihals
  class App < Renee::Application
    app {
      path('/').get.foo!
    }.setup {
      views_path "#{Gem.loaded_specs['schreihals'].full_gem_path}/views"
    }

    def foo!
      render! "index.haml" #view, :layout => "layouts/app", :locals => {:title_part => title }
    end
  end
end
