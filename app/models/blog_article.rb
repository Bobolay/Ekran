class BlogArticle < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :short_description, :content

  image :banner, styles: {media_featured_banner: "1920x540#", thumb: "192x54#", article: "1370x770#"}
  image :avatar, styles: { list: "350x350#", thumb: "100x100#" }

  boolean_scope :published
  scope :order_by_release_date, -> { order("release_date desc") }
  scope :home_featured, -> { published.limit(3) }
  scope :media_featured, -> { published.where(media_featured: 't').limit(3) }

  default_scope do
    order_by_release_date
  end

  has_seo_tags
  has_sitemap_record

  def self.default_priority
    0.7
  end

  has_cache do
    pages :home, :media_blog, self, BlogArticle.published
  end

  has_tags

  before_save :initialize_release_date

  def initialize_release_date
    self.release_date = Date.today if self.release_date.blank?
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(blog_article_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end

  def related_articles
    tag_ids = self.tags.pluck(:id)
    articles = self.class.published.where.not(id: self.id)
    if tag_ids.any?
      articles = articles.joins(taggings: { tag: {} }).where(cms_tags: { id: tag_ids }).uniq
    end

    articles = articles.limit(3)
  end

  def self.tag_url(tag, selected_tags = [])
    base_url = self.base_url

    tags_part_str = Cms::Helpers::PaginationHelper.tags_url_fragment(tag, selected_tags)
    if tags_part_str.blank?
      return base_url
    end

    base_url + "/" + tags_part_str
  end

  def tags
    super.limit(1)
  end

  def self.base_url(locale = I18n.locale)
    Cms.url_helpers.send("media_blog_#{locale}_path")
  end

  def url(locale = I18n.locale)
    url_fragment = self.translations_by_locale[locale].try(:url_fragment)
    return nil if url_fragment.blank?
    self.class.base_url(locale) + "/" + url_fragment
  end

  def formatted_release_date
    ApplicationHelper.formatted_date(release_date)
  end
end