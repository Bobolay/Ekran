class Pages::AboutUs < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/about_us"
  end
end