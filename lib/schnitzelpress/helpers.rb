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
        'glass' => 'f000',
        'music' => 'f001',
        'search' => 'f002',
        'envelope' => 'f003',
        'heart' => 'f004',
        'star' => 'f005',
        'star-empty' => 'f006',
        'user' => 'f007',
        'film' => 'f008',
        'th-large' => 'f009',
        'th' => 'f00a',
        'th-list' => 'f00b',
        'ok' => 'f00c',
        'remove' => 'f00d',
        'zoom-in' => 'f00e',
        'zoom-out' => 'f010',
        'off' => 'f011',
        'signal' => 'f012',
        'cog' => 'f013',
        'trash' => 'f014',
        'home' => 'f015',
        'file' => 'f016',
        'time' => 'f017',
        'road' => 'f018',
        'download-alt' => 'f019',
        'download' => 'f01a',
        'upload' => 'f01b',
        'inbox' => 'f01c',
        'play-circle' => 'f01d',
        'repeat' => 'f01e',
        'refresh' => 'f021',
        'list-alt' => 'f022',
        'lock' => 'f023',
        'flag' => 'f024',
        'headphones' => 'f025',
        'volume-off' => 'f026',
        'volume-down' => 'f027',
        'volume-up' => 'f028',
        'qrcode' => 'f029',
        'barcode' => 'f02a',
        'tag' => 'f02b',
        'tags' => 'f02c',
        'book' => 'f02d',
        'bookmark' => 'f02e',
        'print' => 'f02f',
        'camera' => 'f030',
        'font' => 'f031',
        'bold' => 'f032',
        'italic' => 'f033',
        'text-height' => 'f034',
        'text-width' => 'f035',
        'align-left' => 'f036',
        'align-center' => 'f037',
        'align-right' => 'f038',
        'align-justify' => 'f039',
        'list' => 'f03a',
        'indent-left' => 'f03b',
        'indent-right' => 'f03c',
        'facetime-video' => 'f03d',
        'picture' => 'f03e',
        'pencil' => 'f040',
        'map-marker' => 'f041',
        'adjust' => 'f042',
        'tint' => 'f043',
        'edit' => 'f044',
        'share' => 'f045',
        'check' => 'f046',
        'move' => 'f047',
        'step-backward' => 'f048',
        'fast-backward' => 'f049',
        'backward' => 'f04a',
        'play' => 'f04b',
        'pause' => 'f04c',
        'stop' => 'f04d',
        'forward' => 'f04e',
        'fast-forward' => 'f050',
        'step-forward' => 'f051',
        'eject' => 'f052',
        'chevron-left' => 'f053',
        'chevron-right' => 'f054',
        'plus-sign' => 'f055',
        'minus-sign' => 'f056',
        'remove-sign' => 'f057',
        'ok-sign' => 'f058',
        'question-sign' => 'f059',
        'info-sign' => 'f05a',
        'screenshot' => 'f05b',
        'remove-circle' => 'f05c',
        'ok-circle' => 'f05d',
        'ban-circle' => 'f05e',
        'arrow-left' => 'f060',
        'arrow-right' => 'f061',
        'arrow-up' => 'f062',
        'arrow-down' => 'f063',
        'share-alt' => 'f064',
        'resize-full' => 'f065',
        'resize-small' => 'f066',
        'plus' => 'f067',
        'minus' => 'f068',
        'asterisk' => 'f069',
        'exclamation-sign' => 'f06a',
        'gift' => 'f06b',
        'leaf' => 'f06c',
        'fire' => 'f06d',
        'eye-open' => 'f06e',
        'eye-close' => 'f070',
        'warning-sign' => 'f071',
        'plane' => 'f072',
        'calendar' => 'f073',
        'random' => 'f074',
        'comment' => 'f075',
        'magnet' => 'f076',
        'chevron-up' => 'f077',
        'chevron-down' => 'f078',
        'retweet' => 'f079',
        'shopping-cart' => 'f07a',
        'folder-close' => 'f07b',
        'folder-open' => 'f07c',
        'resize-vertical' => 'f07d',
        'resize-horizontal' => 'f07e',
        'bar-chart' => 'f080',
        'twitter-sign' => 'f081',
        'facebook-sign' => 'f082',
        'camera-retro' => 'f083',
        'key' => 'f084',
        'cogs' => 'f085',
        'comments' => 'f086',
        'thumbs-up' => 'f087',
        'thumbs-down' => 'f088',
        'star-half' => 'f089',
        'heart-empty' => 'f08a',
        'signout' => 'f08b',
        'linkedin-sign' => 'f08c',
        'pushpin' => 'f08d',
        'external-link' => 'f08e',
        'signin' => 'f090',
        'trophy' => 'f091',
        'github-sign' => 'f092',
        'upload-alt' => 'f093',
        'lemon' => 'f094'
      }

      char = map[name.to_s] || 'f06a'

      "<span class=\"font-awesome\">&#x#{char};</span>"
    end

    def link_to(title, target = "", options = {})
      options[:href] = target.respond_to?(:to_url) ? target.to_url : target
      options[:data] ||= {}
      [:method, :confirm].each { |a| options[:data][a] = options.delete(a) }
      haml "%a#{options} #{title}"
    end

    def link_to_delete_post(title, post)
      link_to title, "/admin/edit/#{post.id}", :method => :delete, :confirm => "Are you sure? This can not be undone."
    end
  end
end
