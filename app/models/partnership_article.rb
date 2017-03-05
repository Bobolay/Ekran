class PartnershipArticle < ActiveRecord::Base
  attr_accessible *attribute_names
  include TextFields

  globalize :list_item_title, :name, :url_fragment, :banner_title, :content

  image :list_item_image, styles: { large: "275x500#" }, processors: [:thumbnail, :tinify]
  image :avatar, styles: { article: "400x230#" }, processors: [:thumbnail, :tinify]

  boolean_scope :published
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages :partnership, self, PartnershipArticle.published
  end

  def url(locale = I18n.locale)
    "/partnership/#{translations_by_locale[locale].url_fragment}"
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(partnership_article_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end

  def phones=(val)
    send(:line_separated_field, :phones, val)
  end

  def phones(parse = true)
    line_separated_field(:phones, parse)
  end

  def emails=(val)
    send(:line_separated_field, :emails, val)
  end

  def emails(parse = true)
    line_separated_field(:emails, parse)
  end
end
