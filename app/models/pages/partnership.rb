class Pages::Partnership < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/partnership"
  end
end