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

  def brands

  end

  def services
    @render_footer = false

  end

  def service_one

  end

  def media_all
    @render_footer = false

  end

  def media_news
    @category = "news"
  end

  def media_new_one

  end

  def media_blog
    @category = "blog"

  end

  def media_blog_one

  end

  def media_video
    @category = "video"

  end

  def media_press
    @category = "press"

  end

  def vacancy_one

  end

  def contacts

  end

  private

  def set_page_instance
  #   set_page_metadata(action_name)
  end
end