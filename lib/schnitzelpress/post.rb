require 'tilt'
require 'coderay'

module SchnitzelPress
  class MarkdownRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      CodeRay.highlight(code, language)
    end
  end

  class Post
    include Mongoid::Document
    store_in :posts

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

    # extra
    field :body_html, type: String

    validates_presence_of :title, :body, :status, :slug
    validates_inclusion_of :status, in: [:draft, :published]

    scope :published, where(:status => :published)
    scope :drafts,    where(:status => :draft)
    scope :pages,     where(:published_at.exists => false)
    scope :posts,     where(:published_at.exists => true)
    scope :article_posts, -> { posts.where(:link => nil) }
    scope :link_posts, -> { posts.where(:link.ne => nil) }
    scope :for_year,  ->(year) { d = Date.new(year) ; where(published_at: (d.beginning_of_year)..(d.end_of_year)) }
    scope :for_month, ->(year, month) { d = Date.new(year, month) ; where(published_at: (d.beginning_of_month)..(d.end_of_month)) }
    scope :for_day,   ->(year, month, day) { d = Date.new(year, month, day) ; where(published_at: (d.beginning_of_day)..(d.end_of_day)) }
    scope :latest, -> { published.posts.desc(:published_at) }

    before_validation :nil_if_blank
    before_validation :set_defaults
    validate :validate_slug
    before_save :update_body_html

    def disqus_identifier
      slug
    end

    def slug
      slugs.try(:last)
    end

    def previous_slugs
      slugs[0..-2]
    end

    def published_at=(v)
      v = Chronic.parse(v) if v.is_a?(String)
      super(v)
    end

    def slug=(v)
      unless v.blank?
        slugs.delete(v)
        slugs << v
      end
    end

    def set_defaults
      if slug.blank? && title.present?
        self.slug = title.parameterize
      end
    end

    def validate_slug
      conflicting_posts = Post.where(slugs: slug)
      if published_at.present?
        conflicting_posts = conflicting_posts.for_day(published_at.year, published_at.month, published_at.day)
      end

      if conflicting_posts.any? && conflicting_posts.first != self
        errors[:slug] = "This slug is already in use by another post."
      end
    end

    def nil_if_blank
      attributes.keys.each do |attr|
        self[attr].strip! if self[attr].is_a?(String)
        self[attr] = nil  if self[attr] == ""
      end
    end

    def update_body_html
      self.body_html = render
    end

    def to_html
      if body_html.nil?
        update_body_html
        save
      end

      body_html
    end

    def render
      @@markdown ||= Redcarpet::Markdown.new(MarkdownRenderer,
        autolink: true, space_after_headers: true, fenced_code_blocks: true)

      @@markdown.render(body)
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

    def link_post?
      link.present?
    end

    def article_post?
      link.nil?
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
