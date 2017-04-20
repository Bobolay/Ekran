class Pages::Media < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/media"
  end
end