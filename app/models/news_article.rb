class NewsArticle < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :short_description, :content

  boolean_scope :published
  scope :order_by_release_date, -> { order("release_date desc") }
  scope :home_featured, -> { published.limit(6) }

  default_scope do
    order_by_release_date
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages :home, :media_news, self, NewsArticle.published
  end

  def url(locale = I18n.locale)
    "/#{locale}/media/news/#{translations_by_locale[locale].try(:url_fragment)}"
  end

  has_tags

  before_save :initialize_release_date

  def initialize_release_date
    self.release_date = Date.today if self.release_date.blank?
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(news_article_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end

  def related_articles
    tag_ids = self.tags.pluck(:id)
    articles = self.class.published.where.not(id: self.id)
    if tag_ids.any?
      articles = articles.joins(taggings: { tag: {} }).where(cms_tags: { id: tag_ids }).uniq
    end

    articles = articles.limit(4)
  end

  def self.tag_url(tag, selected_tags = [])
    base_url = self.base_url

    tags_part_str = Cms::Helpers::PaginationHelper.tags_url_fragment(tag, selected_tags)
    if tags_part_str.blank?
      return base_url
    end

    base_url + "/" + tags_part_str
  end

  def self.base_url(locale = I18n.locale)
    "/#{locale}/media/news"
  end

  def formatted_release_date
    ApplicationHelper.formatted_date(release_date)
  end
end
