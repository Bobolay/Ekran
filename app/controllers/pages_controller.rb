class PagesController < ApplicationController
  before_action :set_page_instance, except: [:index]

  def index

  end

  def contacts
    @offices = Office.published
    @office_groups = @offices.group_by{|o| o.region }
  end

  private

  def set_page_instance
     set_page_metadata(action_name)
  end
end