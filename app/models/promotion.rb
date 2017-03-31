class Promotion < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :content

  image :avatar, styles: { list: "400x230#", thumb: "100x100#" }, processors: [:thumbnail, :tinify]
  image :banner, styles: { banner: "1370x770#", thumb: "137x77#" }, processors: [:thumbnail, :tinify]

  boolean_scope :published
  scope :order_by_start_date_time, -> { order("start_date_time desc") }

  default_scope do
    order_by_start_date_time
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages "/partnership/promotions", self, Promotion.published
  end

  def url(locale = I18n.locale)
    promotions_root = PartnershipArticle.promotions.url
    promotions_root + "/#{translations_by_locale[locale].url_fragment}"
  end

  def start_date
    start_date_time
  end

  def end_date
    end_date_time
  end

  def expired?
    self.end_date.present? && self.end_date < DateTime.now
  end

  def infinite?
    !has_end?
  end

  def has_end?
    self.end_date.present?
  end



  def days_remaining
    return :infinite if infinite?

    self.end_date.to_date.mjd - self.start_date.to_date.mjd
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(promotion_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end
end
