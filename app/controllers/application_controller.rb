class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ActionView::Helpers::OutputSafetyHelper
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

  reload_rails_admin_config

  before_action :initialize_breadcrumbs, unless: :admin_panel?
  before_action :initialize_menu_resources

  def render_not_found
    @render_footer = false
    render template: "errors/not_found.html.slim"
  end

  def admin_panel?
    request.path.start_with?("/admin")
  end

  def initialize_breadcrumbs
    if (controller_name != 'pages' || action_name != 'index') || !params[:controller].start_with?("rails_admin") || !params[:controller].start_with?("devise")
      @_breadcrumbs = []
      add_home_breadcrumb
    end
  end

  def initialize_menu_resources
    @partnership_articles = PartnershipArticle.published
  end


end
