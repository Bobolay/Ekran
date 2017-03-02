class Service < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :short_description, :banner_title, :content

  image :avatar, styles: { article: "400x230#" }
  image :large_image, styles: { large: "670x1000#" }



  boolean_scope :published
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages :home, :media_blog, self, BlogArticle.published
  end

  def url(locale = I18n.locale)
    "/services/#{translations_by_locale[locale].url_fragment}"
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(service_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end
end
