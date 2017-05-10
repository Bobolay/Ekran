module LocalizedRoutes
  module UrlHelper
    module ActiveRecordExtension
      def url(locale = I18n.locale)
        url_helpers.send("#{route_name}_#{locale}_path")
      end
    end
  end
end

#Cms::Page.send(:include, LocalizedRoutes::UrlHelper::ActiveRecordExtension)