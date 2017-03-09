class ServicesController < ApplicationController
  before_action :add_services_breadcrumb

  def index
    @render_footer = false
    @services = Service.published
    set_page_metadata(:services)
  end

  def show
    @service = Service.get(params[:id])
    if @service.nil?
      return render_not_found
    end

    add_breadcrumb(@service.name, @service.url, nil, true, "components.breadcrumbs", "-")
    @services = Service.published
    @prev = @service.prev(@services)
    @next = @service.next(@services)
  end

  private
  def add_services_breadcrumb
    add_breadcrumb(:services, services_path)
  end
end