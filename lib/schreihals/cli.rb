require "thor"

class Schreihals::Cli < Thor
  include Thor::Actions

  source_root(File.expand_path('../../templates', __FILE__))

  desc "create NAME", "Creates a new Schreihals blog."

  method_option :git, :aliases => "-g", :default => false,
    :desc => "Initialize a git repository in your blog's directory."

  method_option :bundle, :aliases => "-b", :default => false,
    :desc => "Run 'bundle install' after generating your new blog."

  def create(name)
    @name = name
    self.destination_root = name
    directory 'new_blog', '.'
    template 'first-post.md.tt', "posts/#{Date.today.strftime("%Y-%m-%d")}-first-post.md"

    in_root do
      run "bundle"   if options[:bundle]
      run "git init" if options[:git]
    end
  end
end
