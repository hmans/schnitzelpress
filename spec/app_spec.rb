require 'spec_helper'

describe Schreihals::App do
  include Rack::Test::Methods

  def app
    Schreihals::App
  end

  it "says hello" do
    get '/'
    last_response.should be_ok
  end
end
