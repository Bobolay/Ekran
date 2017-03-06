class Brand < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :multiline_name, :home_slide_name, :short_description, :brand_url

  image :bg_svg_icon
  image :image, styles: { large: "1050x1050#" }
  image :svg_icon


  boolean_scope :published
  boolean_scope :featured
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_cache do
    pages :brands
  end
end
