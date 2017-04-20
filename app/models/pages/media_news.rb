class Pages::MediaNews < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/media/news"
  end
end