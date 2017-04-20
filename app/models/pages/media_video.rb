class Pages::MediaVideo < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/media/video"
  end
end