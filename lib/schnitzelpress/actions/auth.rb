require 'omniauth'
require 'omniauth-browserid'

module Schnitzelpress
  module Actions
    module Auth
      extend ActiveSupport::Concern

      included do
        use OmniAuth::Strategies::BrowserID

        post '/auth/:provider/callback' do
          auth = request.env['omniauth.auth']
          session[:auth] = {:provider => auth['provider'], :uid => auth['uid']}

          # if no configuration is present yet, make this user the blog's admin
          if config.author_email.blank?
            config.update_attributes!(:author_email => auth['uid'])
          end

          redirect admin_logged_in? ? '/admin/' : '/'
        end

        get '/login' do
          haml :'login'
        end

        get '/logout' do
          session[:auth] = nil
          redirect '/login'
        end
      end
    end
  end
end
