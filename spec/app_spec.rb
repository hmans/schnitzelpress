require 'spec_helper'

class MyTestApp < Schreihals::App
  set :documents_source, './spec/posts'
end

describe 'apps derived from Schreihals::App' do
  include Rack::Test::Methods

  def app
    MyTestApp
  end

  describe 'rendering the home page' do
    subject { get '/' ; last_response }
    it { should be_ok }
  end
end
