require 'packr'


module Schnitzelpress
  class JavascriptPacker
    def self.pack_javascripts!(files)
      plain = files.map do |filename|
        File.read(File.expand_path("../lib/assets/js/#{filename}", settings.root))
      end.join("\n")

      Packr.pack(plain)
    end
  end

  module Actions
    module Assets
      extend ActiveSupport::Concern

      ASSET_TIMESTAMP = Time.now.to_i
      JAVASCRIPT_ASSETS = ['jquery-1.7.1.js', 'jquery.cookie.js', 'schnitzelpress.js']

      included do
        get '/assets/schnitzelpress.:timestamp.css' do
          cache_control :public, :max_age => 1.year.to_i
          scss :blog
        end

        get '/assets/schnitzelpress.:timestamp.js' do
          cache_control :public, :max_age => 1.year.to_i
          content_type 'text/javascript; charset=utf-8'
          JavascriptPacker.pack_javascripts!(JAVASCRIPT_ASSETS)
        end
      end
    end
  end
end
