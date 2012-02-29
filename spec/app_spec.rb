require 'spec_helper'

describe Schnitzelpress::App do
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
    its(:body) { should have_tag 'title', :text => "A Test Blog" }
    its(:body) { should have_tag 'section.posts > article.post.published', :count => 5 }
    its(:body) { should_not have_tag 'section.posts > article.post.draft' }
  end

  describe 'the /blog page' do
    before { get '/blog' }
    subject { last_response }
    it { should be_ok }
  end

  describe 'the public feed url' do
    before do
      TestApp.set :feed_url, 'http://feeds.feedburner.com/example_org'
      get '/feed'
    end

    subject { last_response }
    it { should be_redirect }
    its(:status) { should == 307 }
    specify { subject["Location"].should == 'http://feeds.feedburner.com/example_org' }
  end

  describe 'viewing a single post' do
    context 'when the post has multiple slugs' do
      before do
        @post = Factory(:published_post, :published_at => "2011-12-10 12:00", :slugs => ['ancient-slug', 'old-slug', 'current-slug'])
      end

      it 'should enforce the canonical URL' do
        get "/2011/12/10/ancient-slug/"
        last_response.should be_redirect
        last_response["Location"].should == "http://example.org/2011/12/10/current-slug/"
      end
    end
  end
end
