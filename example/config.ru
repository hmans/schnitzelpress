require 'schreihals'

class MyBlog < Schreihals::App
  set :blog_title, "The Blog of AWESOME"
  set :author_name, "Mr. Schreihals"
end

run MyBlog
