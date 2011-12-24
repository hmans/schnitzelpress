require 'schreihals/version'
require 'sinatra'
require 'haml'
require 'sass'
require 'redcarpet'
require 'schnitzelstyle'
require 'document_mapper'
require 'rack-cache'
require 'coderay'
require 'rack/codehighlighter'

require 'active_support/core_ext/string/inflections'

module Schreihals
  class Post
    include DocumentMapper::Document

    def after_load
      # Set some defaults
      #
      self.attributes = {
        disqus: true,
        status: 'published',
        summary: nil,
        link: nil
      }.merge(attributes)

      # Set slug
      #
      if !attributes.has_key? :slug
        begin
          match = attributes[:file_name_without_extension].match(/(\d{4}-\d{1,2}-\d{1,2}[-_])?(.*)/)
          attributes[:slug] = match[2]
        rescue NoMethodError => err
        end
      end
    end

    def to_url
      date.present? ? "/#{year}/#{month}/#{day}/#{slug}/" : "/#{slug}/"
    end

    def disqus_identifier
      attributes[:disqus_identifier] || file_name_without_extension
    end

    def disqus?
      disqus && published?
    end

    def published?
      status == 'published'
    end

    def post?
      date.present?
    end

    def page?
      !post?
    end
  end

  class App < Sinatra::Application
    set :blog_title, "My Schreihals Blog"
    set :blog_url, ""
    set :blog_description, ""
    set :author_name, "Author"
    set :disqus_name, nil
    set :google_analytics_id, nil
    set :read_more, "Read Complete Article"

    use Rack::ShowExceptions
    use Rack::Cache
    use Rack::Static, :urls => ["/media"], :root => "public"
    use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*\n/

    helpers do
      def partial(thing, locals = {})
        name = case thing
          when String then thing
          else thing.class.to_s.demodulize.underscore
        end

        haml :"partials/_#{name}", :locals => { name.to_sym => thing }.merge(locals)
      end

      def set_page_title(title)
        @page_title = title
      end

      def link_to(title, thing)
        haml "%a{href: '#{url_for thing}'} #{title}"
      end

      def url_for(thing, options = {})
        url = thing.respond_to?(:to_url) ? thing.to_url : thing.to_s
        url = "#{settings.blog_url}#{url}" if options[:absolute]
        url
      end

      def show_disqus?
        settings.disqus_name.present?
      end

      def production?
        settings.environment.to_sym == :production
      end
    end

    configure do
      Post.directory = 'posts'
    end

    before do
      cache_control :public, :must_revalidate, :max_age => 60
    end

    get '/' do
      @posts = Post.order_by(:date => :desc)
      @posts = @posts.where(:status => 'published') if production?
      @posts = @posts.limit(10).all
      haml :index
    end

    get '/schreihals.css' do
      scss :schreihals
    end

    get '/atom.xml' do
      @posts = Post.where(:status => 'published').order_by(:date => :desc).limit(10).all
      content_type 'application/xml+atom'
      haml :atom, :layout => false
    end

    get '/:year/:month/:day/:slug/?' do |year, month, day, slug|
      render_page(slug)
    end

    get '/:slug/?' do |slug|
      render_page(slug)
    end

    def render_page(slug)
      if @post = Post.where(:slug => slug).first
        haml :post
      else
        halt 404
      end
    end

    not_found do
      haml :"404"
    end
  end
end
