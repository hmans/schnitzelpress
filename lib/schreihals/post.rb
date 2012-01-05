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
        link: nil,
        read_more: nil
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
end
