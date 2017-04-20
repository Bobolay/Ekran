class Pages::MediaBlog < Cms::Page
  def url(locale = I18n.locale)
    "/#{locale}/media/blog"
  end
end