require "thor"

module Schnitzelpress
  class Cli < Thor
    include Thor::Actions

    source_root(File.expand_path('../../templates', __FILE__))

    desc "create NAME", "Creates a new Schnitzelpress blog."
    method_option :git, :aliases => "-g", :default => false, :type => :boolean,
      :desc => "Initialize a git repository in your blog's directory."

    def create(name)
      @name = name
      self.destination_root = name
      directory 'new_blog', '.'

      in_root do
        if options[:git]
          run "git init"
          run "git add ."
          run "git commit -m 'Created new Schnitzelpress blog'"
        end
      end
    end

    desc "update", "Update your blog's bundled Schnitzelpress version."
    def update
      run "bundle update schnitzelpress"
    end

    desc "console", "Run the Schnitzelpress console."
    def console
      require 'schnitzelpress'
      require 'pry'
      Schnitzelpress.init!
      ARGV.clear
      pry Schnitzelpress
    end

    desc "mongo_pull", "Pulls contents of remote MongoDB into your local MongoDB"
    def mongo_pull
      abort "Please set MONGO_URL." unless ENV['MONGO_URL']
      system "heroku mongo:pull"
    end

    desc "mongo_push", "Pushes contents of your local MongoDB to remote MongoDB"
    def mongo_push
      abort "Please set MONGO_URL." unless ENV['MONGO_URL']
      system "heroku mongo:push"
    end
  end
end
