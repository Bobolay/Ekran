class BrandsController < ApplicationController
  def index
    set_page_metadata(:brands)
    @featured_brands = Brand.published.featured
    @other_brands = Brand.published.unfeatured
  end
end