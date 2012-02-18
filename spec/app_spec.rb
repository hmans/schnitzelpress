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

  describe 'the public feed url' do
    before do
      TestApp.set :feed_url, 'http://feeds.feedburner.com/example_org'
      get '/feed'
    end

    subject { last_response }
    it { should be_redirect }
    its(:status) { should == 302 }
    specify { subject["Location"].should == 'http://feeds.feedburner.com/example_org' }
  end
end
