class Brand < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :short_name, :multiline_name, :home_slide_name, :short_description, :brand_url, :url_fragment, :content

  image :bg_svg_icon
  image :image, styles: { large: "1050x1050#" }
  image :svg_icon

  image :article_image, styles: { article: "400x230#" }


  boolean_scope :published
  boolean_scope :featured
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_many :projects
  attr_accessible :projects, :project_ids

  has_seo_tags
  has_sitemap_record
  has_cache do
    pages :brands, self, Brand.published
  end

  def url(locale = I18n.locale)
    "/brands/#{translations_by_locale[locale].url_fragment}"
  end

  def self.get(url_fragment)
    self.published.featured.joins(:translations).where(brand_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end
end
