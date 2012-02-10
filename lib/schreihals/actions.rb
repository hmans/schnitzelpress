module Schreihals
  module Actions
    extend ActiveSupport::Concern

    included do
      before do
        cache_control :public, :must_revalidate, :max_age => 60
      end

      get '/' do
        @posts = Post.where(status: :published).desc(:published_at)
        @show_description = true
        haml :index
      end

      get '/blog.css' do
        scss :blog
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
