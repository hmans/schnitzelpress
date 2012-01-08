module Schreihals
  module Actions
    extend ActiveSupport::Concern

    included do
      before do
        refresh_documents! if refresh_documents_now?
        cache_control :public, :must_revalidate, :max_age => 60
      end

      get '/' do
        @posts = Post.latest(published_only: production?)

        @show_description = true
        haml :index
      end

      get '/schreihals.css' do
        scss :schreihals
      end

      get '/atom.xml' do
        @posts = Post.latest(published_only: production?)

        xml = haml :atom, :layout => false

        doc = Nokogiri::XML(xml)
        doc.css("content img").each do |node|
          node['src'] = absolutionize(node['src'])
        end

        content_type 'application/xml+atom'
        doc.to_xml
      end

      get '/:year/:month/:day/:slug/?' do |year, month, day, slug|
        render_page(slug)
      end

      get '/:slug/?' do |slug|
        render_page(slug)
      end
    end
  end
end
