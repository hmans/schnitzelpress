require_relative 'test_helper'

class MyTestApp < Schreihals::App
  set :documents_source, './test/posts'
end

context Schreihals::App do
  setup { Rack::MockRequest.new(MyTestApp.new) }

  context "GET /" do
    setup { topic.get '/' }
    asserts(:status).equals 200
    asserts(:body).present?
    asserts(:content_type).equals 'text/html;charset=utf-8'
    asserts(:body).includes_elements("section.posts article.post", 2)
  end
end
