class Project < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :multiline_name, :url_fragment, :short_description, :content, :client, :address

  boolean_scope :published
  boolean_scope :featured
  scope :order_by_date, -> { order("date desc") }

  default_scope do
    order_by_date
  end

  belongs_to :brand

  image :image, styles: { large: "685x685#", thumb: "100x100#" }
  image :featured_banner, styles: {large: "1920x500#", thumb: "192x50#"}
  has_images :slider_images, class_name: "ProjectSliderImage"
  has_images :gallery_images, class_name: "ProjectGalleryImage"

  has_seo_tags
  has_sitemap_record

  def self.default_priority
    0.7
  end

  def self.default_change_freq
    :yearly
  end

  has_cache do
    pages :home, :projects, Project.published, self
  end

  include LocalizedRoutes::UrlHelper::ResourceUrl

  before_save :initialize_date

  def initialize_date
    self.date = Date.today if self.date.blank?
  end

  def year
    date.year
  end

  def self.get(url_fragment)
    self.published.joins(:translations).where(project_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end


end
