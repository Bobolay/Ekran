Cms::CompressionConfig.initialize_compression(html_compress: false)
Cms::AssetsPrecompile.initialize_precompile
Cms.config.provided_locales do
  [:uk, :en]
end

Cms.config.default_sitemap_priority do
  0.9
end

Cms.config.default_sitemap_change_freq do
  :monthly
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

def ajax_tags_and_pagination_routes(scope = "/ajax/articles", route_prefix = :articles, action= :index, pagination = true)
  scope scope do
    get "tags=:tags", action: action, as: :"ajax_#{route_prefix}_tags"
    if pagination
      get "page/:page", action: action, as: :"ajax_#{route_prefix}_page"
      get "tags=:tags/page/:page", action: action, as: :"ajax_#{route_prefix}_tags_page"
    end
  end
end

def render_tags_and_pagination_routes(route_prefix = :articles, action= :index, pagination = true)
  get "tags=:tags", action: action, as: :"#{route_prefix}_tags"
  if pagination
    get "page/:page", as: :"#{route_prefix}_page", action: action
    get "tags=:tags/page/:page", action: action, as: :"#{route_prefix}_tags_page"
  end
end