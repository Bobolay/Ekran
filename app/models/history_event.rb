class HistoryEvent < ActiveRecord::Base
  attr_accessible *attribute_names

  globalize :name, :short_description

  boolean_scope :published
  scope :order_by_date, -> { order("date desc") }

  default_scope do
    order_by_date
  end

  has_cache do
    pages :about_us
  end

  before_save :initialize_date

  def initialize_date
    self.date = Date.today if self.date.blank?
  end
end
