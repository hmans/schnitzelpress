module Schreihals
  module Actions
    extend ActiveSupport::Concern

    included do
      get '/' do
        cache_for 5.minutes
        @posts = Post.latest
        @show_description = true
        haml :index
      end

      get '/blog.css' do
        cache_for 1.hour
        scss :blog
      end

      get '/atom.xml' do
        cache_for 5.minutes

        @posts = Post.latest

        xml = haml :atom, :layout => false

        doc = Nokogiri::XML(xml)
        doc.css("content img").each do |node|
          node['src'] = absolutionize(node['src'])
        end

        content_type 'application/xml+atom'
        doc.to_xml
      end

      get '/:year/:month/:day/:slug/?' do |year, month, day, slug|
        cache_for 1.hour
        render_page(slug)
      end

      get '/:slug/?' do |slug|
        cache_for 1.hour
        render_page(slug)
      end
    end
  end
end
