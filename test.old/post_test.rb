require_relative 'test_helper'

context Schreihals::Post do
  # setup { Rack::MockRequest.new(MyTestApp.new) }

  # context "when loading the home page" do
  #   setup { topic.get '/' }

  #   asserts(:status).equals 200
  #   asserts(:body).present
  #   asserts(:content_type).equals 'text/html;charset=utf-8'
  #   asserts(:body).includes_elements("section.posts article.post", 2)

  #   asserts(:body).includes_html('title' => MyTestApp.settings.blog_title)
  #   asserts(:body).includes_html('.container>footer' => MyTestApp.settings.footer)
  # end

  # context "when loading a specific post's page" do
  #   setup { topic.get '/2011/12/23/first-post/' }

  #   asserts(:status).equals 200
  #   asserts(:body).present
  #   asserts(:content_type).equals 'text/html;charset=utf-8'
  #   asserts(:body).includes_elements("article.post", 1)
  #   asserts(:body).includes_html('article.post header h2 a' => "First Post\.")
  # end

  # context "when loading a static page" do
  #   setup { topic.get '/static-page/' }

  #   asserts(:status).equals 200
  #   asserts(:body).present
  #   asserts(:content_type).equals 'text/html;charset=utf-8'
  #   asserts(:body).includes_elements("article.post", 1)
  #   asserts(:body).includes_html('article.post header h2 a' => "A Static Page\.")
  # end

  # context "when loading the ATOM feed" do
  #   setup { topic.get '/atom.xml' }

  #   asserts(:status).equals 200
  #   asserts(:body).present
  #   asserts(:content_type).equals 'application/xml+atom'
  #   asserts(:body).includes_elements("entry", 2)
  # end

  # context "when loading a static asset provided by schreihals" do
  #   setup { topic.get '/favicon.ico' }

  #   asserts(:status).equals 200
  #   asserts(:body).present
  #   asserts(:content_type).equals 'image/vnd.microsoft.icon'
  # end

  # context "when loading an invalid URL" do
  #   setup { topic.get '/ooga/booga/foo/to/the/bar' }

  #   asserts(:status).equals 404
  #   asserts(:body).present
  #   asserts(:content_type).equals 'text/html;charset=utf-8'
  # end
end
