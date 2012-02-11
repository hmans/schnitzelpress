require 'tilt'

module Schreihals
  class Post
    include Mongoid::Document

    # basic data
    field :title, type: String
    field :body,  type: String
    field :slugs, type: Array, default: []

    # optional fields
    field :summary,   type: String
    field :link,      type: String
    field :read_more, type: String

    # times & status
    field :published_at, type: DateTime
    field :status,       type: Symbol, default: :draft

    # flags
    field :disqus, type: Boolean, default: false

    validates_presence_of :title, :body, :status, :slug
    validates_inclusion_of :status, in: [:draft, :published]

    scope :latest, where(:status => :published, :published_at.exists => true).desc(:published_at)

    def disqus_identifier
      slug
    end

    def slug
      slugs.try(:last)
    end

    def previous_slugs
      slugs[0..-2]
    end

    def slug=(v)
      unless v.blank?
        slugs.delete(v)
        slugs << v
      end
    end

    def to_html
      Tilt.new("md") { body }.render
    end

    def post?
      published_at.present?
    end

    def page?
      !post?
    end

    def published?
      status == :published
    end

    def draft?
      status == :draft
    end

    def year
      published_at.year
    end

    def month
      published_at.month
    end

    def day
      published_at.day
    end

    def to_url
      published_at.present? ? "/#{year}/#{month}/#{day}/#{slug}/" : "/#{slug}/"
    end

    def disqus?
      disqus && published?
    end
  end
end
