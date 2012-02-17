require 'rubygems'
require 'bundler'
Bundler.require

require 'schreihals'

class MyBlog < Schreihals::App
  configure do
    set :blog_title, "A Schreihals Blog"
    set :blog_description, "An example blog powered by Schreihals."
    set :footer, "powered by [Schreihals](http://schreihals.info)"
    set :author_name, "Hendrik Mans"
    set :disqus_name, "hmans"
    # set :google_analytics_id, "..."
    # set :gauges_id, "..."
    # set :twitter_id, '...'
    # set :read_more, "Read ALL the things"
    set :administrator, "browser_id:hendrik@mans.de"
  end
end

run MyBlog
