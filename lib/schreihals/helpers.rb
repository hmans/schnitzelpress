module Schreihals
  module Helpers
    def find_template(views, name, engine, &block)
      Array(views).each { |v| super(v, name, engine, &block) }
    end

    def base_url
      "#{env['rack.url_scheme']}://#{env['HTTP_HOST']}/"
    end

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
      url = "#{base_url.sub(/\/$/, '')}#{url}" if options[:absolute]
      url
    end

    def show_disqus?
      settings.disqus_name.present?
    end

    def production?
      settings.environment.to_sym == :production
    end

    def user_logged_in?
      session[:user].present?
    end

    def admin_logged_in?
      user_logged_in? && session[:user] == settings.administrator
    end

    def admin_only!
      redirect '/login' unless admin_logged_in?
    end

    def form_field(object, attribute, options = {})
      options = {
        label: attribute.to_s.humanize,
        value: object.send(attribute),
        errors: object.errors[attribute.to_sym],
        class_name: object.class.to_s.demodulize.underscore
      }.merge(options)

      options[:name] ||= "#{options[:class_name]}[#{attribute}]"
      options[:id] ||= object.new_record? ?
        "new_#{options[:class_name]}_#{attribute}" :
        "#{options[:class_name]}_#{object.id}_#{attribute}"
      options[:type] ||= :text

      partial 'form_field', object: object, attribute: attribute, options: options
    end
  end
end
