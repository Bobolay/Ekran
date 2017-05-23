class Pages::MediaNews < Cms::Page
  include LocalizedRoutes::UrlHelper::ActiveRecordExtension

  def self.default_priority
    0.7
  end

  def self.default_change_freq
    :weekly
  end
end