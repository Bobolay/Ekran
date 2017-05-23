class ProjectsController < ApplicationController
  before_action :add_projects_breadcrumb
  caches_page :index, :show

  def index
    set_page_metadata(:projects)
    initialize_locale_links
    projects_collection
    #@filtered_projects = filter_by_tags(@articles)
    @projects_groups = @projects.group_by(&:year)
    @brands = Brand.published.joins(:projects, :translations).where(projects: { published: 't' }).uniq.map{|b| {name: b.name, id: b.id} }
    @years = @projects.map(&:year).uniq.sort{|a, b| b <=> a }
    @featured_project = Project.published.featured.first

    brand_url_fragments = (params[:brands] || "").split(",")
    if brand_url_fragments.count > 0
      @selected_brand_ids = Brand.joins(:translations).where(brand_translations: { locale: I18n.locale, url_fragment: brand_url_fragments }).pluck(:id)
    end
  end

  def show
    @project = Project.get(params[:id])
    if @project.nil?
      return render_not_found
    end

    @slider_images = @project.slider_images
    @gallery_images = @project.gallery_images.select{|i| i.data.exists?}

    @og_image = @project.image.url(:large)

    @shareable_resource = @project

    set_page_metadata(@project)
    initialize_locale_links
    add_breadcrumb(@project.name, @project.url, nil, true, "components.breadcrumbs", "-")

    @prev = @project.prev(projects_collection)
    @next = @project.next(projects_collection)

    @prev = nil if @prev.id == @project.id
    @next = nil if @next.id == @project.id

    @related_projects = [@prev, @next].select(&:present?)
  end

  private
  def add_projects_breadcrumb
    add_breadcrumb(:projects, projects_path)
  end

  def projects_collection
    @projects ||= Project.published
  end
end