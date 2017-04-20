class Pages::Brands < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/brands"
  end
end