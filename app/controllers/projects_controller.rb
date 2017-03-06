class ProjectsController < ApplicationController
  before_action :add_projects_breadcrumb

  def index
    set_page_metadata(:projects)
  end

  def show

  end

  private
  def add_projects_breadcrumb
    add_breadcrumb(:projects, projects_path)
  end
end