class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ActionView::Helpers::OutputSafetyHelper
  include Cms::Helpers::ImageHelper
  include ActionView::Helpers::AssetUrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper
  include Cms::Helpers::UrlHelper
  include Cms::Helpers::PagesHelper
  include Cms::Helpers::MetaDataHelper
  include Cms::Helpers::NavigationHelper
  include Cms::Helpers::ActionView::UrlHelper
  include Cms::Helpers::Breadcrumbs
  include ApplicationHelper

  #reload_rails_admin_config

  before_action :initialize_breadcrumbs, if: :breadcrumbs_enabled?
  before_action :initialize_menu_resources

  def render_not_found
    @render_footer = false
    render template: "errors/not_found.html.slim"
  end

  def admin_panel?
    request.path.start_with?("/admin")
  end

  def breadcrumbs_enabled?
    is_rails_admin = params[:controller].start_with?("rails_admin")
    is_devise = params[:controller].start_with?("devise")
    is_ckeditor = params[:controller].start_with?("ckeditor")
    is_home_page = (controller_name == 'pages' && action_name == 'index')
    is_cms = params[:controller].start_with?("cms/")
    !admin_panel? && !is_home_page && !is_rails_admin && !is_devise && !is_ckeditor && !is_cms
  end

  def initialize_breadcrumbs
    if !params[:controller].start_with?("rails_admin") || !params[:controller].start_with?("devise")
      @_breadcrumbs = []
      add_home_breadcrumb
    end
  end

  def initialize_menu_resources
    @partnership_articles = PartnershipArticle.published
    @menu_featured_brands = Brand.published.featured.joins(:translations).where("brand_translations.brand_url IS NOT NULL AND brand_translations.brand_url <> ''")
  end


end
