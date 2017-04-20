class Pages::Contacts < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/contacts"
  end
end