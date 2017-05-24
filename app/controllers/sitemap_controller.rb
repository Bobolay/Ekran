class SitemapController < ApplicationController
  skip_all_before_action_callbacks

  def index
    @entries = Cms::SitemapElement.entries_for_resources(nil, :uk)

    render "cms/sitemap/index"
  end
end