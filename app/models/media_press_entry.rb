class MediaPressEntry < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name

  pdf :data

  boolean_scope :published
  scope :order_by_release_date, -> { order("release_date desc") }
  #scope :home_featured, -> { published.limit(3) }

  default_scope do
    order_by_release_date
  end

  has_cache do
    pages :home, :media_press
  end

  before_save :initialize_release_date

  def initialize_release_date
    self.release_date = Date.today if self.release_date.blank?
  end

  def formatted_release_date
    ApplicationHelper.formatted_date(release_date)
  end

  def self.base_url(locale = I18n.locale)
    Cms.url_helpers.send("media_press_#{locale}_path")
  end


end
