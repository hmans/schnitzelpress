require 'spec_helper'

describe 'Schnitzelpress::Actions::Assets' do
  include Rack::Test::Methods

  def app
    Schnitzelpress::App
  end

  describe '/assets/schnitzelpress.*.js' do
    before do
      Schnitzelpress::JavascriptPacker.should_receive(:pack_javascripts!).and_return('{123}')
      get '/assets/schnitzelpress.123.js'
    end
    subject { last_response }
    it { should be_ok }
    its(:body) { should == '{123}' }
  end

  describe '/assets/schnitzelpress.*.css' do
    before { get '/assets/schnitzelpress.123.css' }
    subject { last_response }
    it { should be_ok }
    its(:content_type) { should == 'text/css;charset=utf-8' }
  end
end
