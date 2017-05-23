class Pages::Home < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}"
  end

  def self.default_priority
    1
  end
end