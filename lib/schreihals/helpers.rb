module Schreihals
  module Helpers
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
end