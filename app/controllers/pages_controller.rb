class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  def index
    @featured_brands = Brand.published.featured
    @news = NewsArticle.home_featured
    @blog_articles = BlogArticle.home_featured
    @featured_video = MediaVideo.home_featured.first
    @home_slides = HomeSlide.published
    @featured_partnership_articles = PartnershipArticle.published.featured
    @home_projects = Project.published.limit(3)
    set_page_metadata(:home)

    @partnership_roles = PartnershipArticle.published

  end

  def contacts
    @offices = Office.published
    @office_groups = @offices.group_by{|o| o.region }
    add_breadcrumb(:contacts, contacts_path)
  end

  private

  def set_page_instance
     set_page_metadata(action_name)
  end
end