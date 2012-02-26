$stdout.sync = true
require File.expand_path("../app.rb", __FILE__)

# Add some caching. This is designed to work out of the box
# on Heroku, but feel free to change this if eg. you'd prefer
# to use Memcache.
#
if Schnitzelpress.env.production?
  use Rack::Cache, {
    :verbose     => true,
    :metastore   => URI.encode("file:/tmp/cache/meta"),
    :entitystore => URI.encode("file:/tmp/cache/body")
  }
end

# Run the app, with support for files in ./public/
#
run App.with_local_files
