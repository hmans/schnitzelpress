module SchnitzelPress
  class MarkdownRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      CodeRay.highlight(code, language)
    end

    def autolink(link, type)
      OEmbed::Providers.get(link).html
    rescue OEmbed::NotFound
      %q(<a href="%s">%s</a>) % [link, link]
    end
  end
end
