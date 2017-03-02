Cms::CompressionConfig.initialize_compression(html_compress: false)
Cms.config.provided_locales do
  [:uk]
end

Cms.config.use_translations true

def tags_and_pagination_routes(scope = nil, route_prefix = :articles, action= :index, include_ajax = true)
  if scope
    scope scope do
      render_tags_and_pagination_routes(route_prefix, action)
    end
  else
    render_tags_and_pagination_routes(route_prefix, action)
  end

  ajax_scope = scope.present? ?  (scope.start_with?("/") ? "ajax#{scope}" : "ajax/#{scope}" ) : "/ajax"
  ajax_tags_and_pagination_routes(ajax_scope, route_prefix, action)
end

def ajax_tags_and_pagination_routes(scope = "/ajax/articles", route_prefix = :articles, action= :index)
  scope scope do
    get "page/:page", action: action, as: :"ajax_#{route_prefix}_page"
    get "tags=:tags", action: action, as: :"ajax_#{route_prefix}_tags"
    get "tags=:tags/page/:page", action: action, as: :"ajax_#{route_prefix}_tags_page"
  end
end

def render_tags_and_pagination_routes(route_prefix = :articles, action= :index)
  get "tags=:tags", action: action, as: :"#{route_prefix}_tags"
  get "page/:page", as: :"#{route_prefix}_page", action: action
  get "tags=:tags/page/:page", action: action, as: :"#{route_prefix}_tags_page"
end