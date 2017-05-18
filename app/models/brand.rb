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
    #pages Pages.all_instances, self, Brand.published, BlogArticle.published, NewsArticle.published, Service.published, Project.published, Promotion.published, PartnershipArticle.published, Vacancy.published
    pages :all
  end

  include LocalizedRoutes::UrlHelper::ResourceUrl

  has_attachments :downloads

  def self.get(url_fragment)
    self.published.featured.joins(:translations).where(brand_translations: { url_fragment: url_fragment, locale: I18n.locale }).first
  end
end
