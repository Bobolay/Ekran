class Promotion < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :url_fragment, :content

  image :avatar, styles: { list: "400x230#", thumb: "100x100#" }, processors: [:thumbnail, :tinify]

  boolean_scope :published
  scope :order_by_start_date, -> { order("start_date desc") }

  default_scope do
    order_by_start_date
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages "/partnership/promotions", self, Promotion.published
  end

  def url(locale = I18n.locale)
    "/partnership/promotions/#{translations_by_locale[locale].url_fragment}"
  end

  def expired?
    self.end_date.present? && self.end_date < Date.today
  end

  def has_end?
    self.end_date.present?
  end

  def days_remaining
    return :infinite if !has_end?

    self.end_date.mjd - self.start_date.mjd
  end
end
