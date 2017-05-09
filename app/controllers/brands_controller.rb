class BrandsController < ApplicationController
  before_action :add_brands_breadcrumb, only: :show

  def index
    set_page_metadata(:brands)
    initialize_locale_links
    @featured_brands = Brand.published.featured
    @other_brands = Brand.published.unfeatured
  end

  def show
    @article = Brand.get(params[:id])
    if @article.nil?
      return render_not_found
    end

    set_page_metadata(@article)
    #add_breadcrumb(@article.name, @article.url, nil, true, "components.breadcrumbs", "-")
    add_breadcrumb(@article.name, @article.url)
    initialize_locale_links
    @articles = Brand.published.featured
    @prev = @article.prev(@articles)
    @next = @article.next(@articles)
    @related_projects = @article.projects
  end

  private
  def add_brands_breadcrumb
    add_breadcrumb(:brands, brands_path)
  end
end