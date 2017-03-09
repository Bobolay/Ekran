module CmsPageExtension
  def self.included(base)
    base.scope :order_by_sorting_position, -> do
      base.current_scope.order("sorting_position asc")
    end
    base.send(:default_scope) do
      -> {
        order_by_sorting_position
      }

    end

    def name
      k = type.underscore.split("/").last
      I18n.t("activerecord.models.pages.#{k}", raise: true) rescue k.humanize
    end
  end
end

# Cms::Page.class_eval do
#   #self.table_name = :pages
#
#
#
#
#
# end

Cms::Page.send(:include, CmsPageExtension)