class AboutCertificate < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name

  image :image, styles: { large: "1800x900>", thumb: "200x280#" }

  boolean_scope :published
  scope :order_by_date, -> { order("date desc") }

  default_scope do
    order_by_date
  end

  has_cache do
    pages :about_us
  end

  def formatted_date
    ApplicationHelper.formatted_date(date)
  end
end
