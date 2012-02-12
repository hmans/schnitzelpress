require 'omniauth'
require 'omniauth-browserid'

module Schreihals
  module Actions
    module Auth
      extend ActiveSupport::Concern

      included do
        use OmniAuth::Strategies::BrowserID

        post '/auth/:provider/callback' do
          auth = request.env['omniauth.auth']
          session[:user] = "#{auth['provider']}:#{auth['uid']}"
          redirect admin_logged_in? ? '/admin/' : '/'
        end

        get '/login' do
          redirect '/auth/browser_id'
        end

        get '/logout' do
          session[:user] = nil
          redirect '/'
        end
      end
    end
  end
end
