class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  def index

  end

  def contacts

  end

  private

  def set_page_instance
     set_page_metadata(action_name)
  end
end