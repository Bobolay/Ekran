class AboutSlide < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :image_alt

  image :image, styles: { large: "1920x1280#" }

  boolean_scope :published
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_cache do
    pages :about_us
  end
end
