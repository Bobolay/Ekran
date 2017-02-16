class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  self.layout "home"

  def index
  #   set_page_metadata(:home)
  end

  def about_us

  end

  def projects_all

  end

  def project_one

  end

  def partnership

  end

  def partner_training_center

  end

  private

  def set_page_instance
  #   set_page_metadata(action_name)
  end
end