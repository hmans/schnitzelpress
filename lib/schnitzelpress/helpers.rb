module Schnitzelpress
  module Helpers
    def h(*args)
      escape_html(*args)
    end

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

    def config
      Schnitzelpress::Config.instance
    end

    def set_page_title(title)
      @page_title = title
    end

    def url_for(thing, options = {})
      url = thing.respond_to?(:to_url) ? thing.to_url : thing.to_s
      url = "#{base_url.sub(/\/$/, '')}#{url}" if options[:absolute]
      url
    end

    def show_disqus?
      config.disqus_id.present?
    end

    def production?
      settings.environment.to_sym == :production
    end

    def user_logged_in?
      session[:auth].present?
    end

    def admin_logged_in?
      user_logged_in? && (session[:auth][:uid] == config.author_email)
    end

    def admin_only!
      redirect '/login' unless admin_logged_in?
    end

    def form_field(object, attribute, options = {})
      options = {
        :label => attribute.to_s.humanize.titleize,
        :value => object.send(attribute),
        :errors => object.errors[attribute.to_sym],
        :class_name => object.class.to_s.demodulize.underscore
      }.merge(options)

      options[:name] ||= "#{options[:class_name]}[#{attribute}]"
      options[:id] ||= object.new_record? ?
        "new_#{options[:class_name]}_#{attribute}" :
        "#{options[:class_name]}_#{object.id}_#{attribute}"
      options[:class] ||= "#{options[:class_name]}_#{attribute}"

      options[:type] ||= case options[:value]
        when DateTime, Time, Date then :datetime
        when Boolean, FalseClass, TrueClass then :boolean
        else :text
      end

      partial 'form_field', :object => object, :attribute => attribute, :options => options
    end

    def icon(name)
      map = {
        'eye-open' => 'f06e',
        'edit' => 'f044',
        'trash' => 'f014'
      }

      char = map[name.to_s] || 'f06a'

      "<span class=\"font-awesome\">&#x#{char};</span>"
    end
  end
end
