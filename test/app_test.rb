require_relative 'test_helper'

class MyTestApp < Schreihals::App
  set :documents_source, './test/posts'
end

context Schreihals::App do
  setup { Rack::MockRequest.new(MyTestApp.new) }

  context "when loading the home page" do
    setup { topic.get '/' }

    asserts(:status).equals 200
    asserts(:body).present
    asserts(:content_type).equals 'text/html;charset=utf-8'
    asserts(:body).includes_elements("section.posts article.post", 2)
  end

  context "when loading a specific post's page" do
    setup { topic.get '/2011/12/23/first-post/' }

    asserts(:status).equals 200
    asserts(:body).present
    asserts(:content_type).equals 'text/html;charset=utf-8'
    asserts(:body).includes_elements("section.post article.post", 1)
    asserts(:body).includes_html('section.post article.post header h2 a' => "First Post\.")
  end
end
