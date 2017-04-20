class Pages::Projects < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/projects"
  end
end