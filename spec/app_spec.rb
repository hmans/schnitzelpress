require 'spec_helper'

class TestApp < Schreihals::App
  configure do
    set :blog_title, "A Test Blog"
  end
end

describe Schreihals::App do
  include Rack::Test::Methods

  def app
    TestApp
  end

  describe 'the home page' do
    before { get '/' }
    subject { last_response }

    it { should be_ok }
    its(:body) { should have_tag 'title', text: "A Test Blog" }
  end
end
