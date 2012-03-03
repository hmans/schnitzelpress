module Schnitzelpress
  class MarkdownRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      CodeRay.highlight(code, language)
    end

    def image(link, title, alt_text)
      oembed = OEmbed::Providers.get(link)
      %q(<div class="embedded %s %s">%s</div>) % [oembed.type, oembed.provider_name.parameterize, oembed.html]
    rescue OEmbed::NotFound
      %q(<img src="%s" title="%s" alt="%s"/>) % [link, escape_html(title), escape_html(alt_text)]
    end

    def escape_html(html)
      Rack::Utils.escape_html(html)
    end
  end
end
