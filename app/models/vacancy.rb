class Vacancy < ActiveRecord::Base
  include Enumerize
  attr_accessible *attribute_names

  globalize :salary, :position, :content

  enumerize :contract_type, in: [:part_time, :full_time, :remote]

  boolean_scope :published
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_cache do
    pages :about_us, self
  end
end
