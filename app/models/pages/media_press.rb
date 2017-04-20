class Pages::MediaPress < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/media/press"
  end
end