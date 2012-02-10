require 'tilt'

module Schreihals
  class Post
    include Mongoid::Document

    # def initialize(*args)
    #   super
    #   self.attributes = {
    #     'disqus'    => true,
    #     'status'    => 'published',
    #     'summary'   => nil,
    #     'link'      => nil,
    #     'read_more' => nil,
    #     'date'      => nil,
    #     'title'     => nil,
    #     'slug'      => nil,
    #     'disqus_identifier' => file_name
    #   }.merge(attributes)

    #   # extract date and slug from file name, if possible
    #   if file_name_without_extension =~ /^(\d{4}-\d{1,2}-\d{1,2})-?(.+)$/
    #     attributes['date'] ||= Date.parse($1)
    #     attributes['slug'] ||= $2
    #   else
    #     attributes['slug'] ||= file_name_without_extension
    #   end
    # end

  #   def year
  #     date.year
  #   end

  #   def month
  #     date.month
  #   end

  #   def day
  #     date.day
  #   end

  #   def to_url
  #     date.present? ? "/#{year}/#{month}/#{day}/#{slug}/" : "/#{slug}/"
  #   end

  #   def disqus?
  #     disqus && published?
  #   end

  #   def published?
  #     status == 'published'
  #   end

  #   def post?
  #     date.present?
  #   end

  #   def page?
  #     !post?
  #   end

  #   class << self
  #     def latest(options = {})
  #       options = {published_only: false}.merge(options)

  #       posts = documents.select(&:date)
  #       posts = posts.select(&:published?) if options[:published_only]
  #       posts.sort_by(&:date).reverse.first(10)
  #     end

  #     def with_slug(slug)
  #       documents.detect { |p| p.slug == slug }
  #     end
  #   end
  end
end
