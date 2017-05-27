class PartnershipArticle < ActiveRecord::Base
  attr_accessible *attribute_names
  include Cms::TextFields

  globalize :list_item_title, :role_name, :name, :url_fragment, :banner_title, :content

  image :list_item_image, styles: { large: "275x500#" }
  image :avatar, styles: { article: "400x230#" }

  boolean_scope :published
  boolean_scope :featured
  scope :order_by_sorting_position, -> { order("sorting_position asc") }

  default_scope do
    order_by_sorting_position
  end

  has_seo_tags
  has_sitemap_record
  has_cache do
    #pages :home, :partnership, self, PartnershipArticle.published
    pages :all
  end

  include LocalizedRoutes::UrlHelper::ResourceUrl

  def self.get(url_fragment)
    self.published.joins(:translations).where(partnership_article_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end

  def phones=(val)
    send(:line_separated_field=, :phones, val)
  end

  def phones(parse = true)
    line_separated_field(:phones, parse)
  end

  def emails=(val)
    send(:line_separated_field=, :emails, val)
  end

  def emails(parse = true)
    line_separated_field(:emails, parse)
  end

  def self.roles
    published.map{|a| next nil if a.role_name.blank?; [a.role_name, a.id]}.select(&:present?)
  end

  def promotions?
    self.id == 4
  end

  def self.promotions
    find(4) rescue nil
  end

end
