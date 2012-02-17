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
    before do
      2.times { Factory(:draft_post) }
      5.times { Factory(:published_post) }
      get '/'
    end

    subject { last_response }

    it { should be_ok }
    its(:body) { should have_tag 'title', text: "A Test Blog" }
    its(:body) { should have_tag 'section.posts > article.post.published', count: 5 }
    its(:body) { should_not have_tag 'section.posts > article.post.draft' }
  end
end
