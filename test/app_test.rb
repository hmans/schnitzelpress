require_relative 'test_helper'

class MyTestApp < Schreihals::App
  set :documents_source, './test/posts'
end

context Schreihals::App do
  setup do
    @app = Rack::MockRequest.new(MyTestApp.new)
  end

  context "GET /" do
    setup { @app.get '/' }
    asserts("returns 200") { topic.status }.equals 200
  end
end
