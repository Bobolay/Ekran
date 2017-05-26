class MediaController < ApplicationController
  include Cms::Helpers::PaginationHelper
  before_action :add_media_breadcrumb
  before_action :add_blog_breadcrumb, only: [:blog_index, :blog_show]
  before_action :add_news_breadcrumb, only: [:news_index, :news_show]
  before_action :set_featured_articles, only: [:blog_index, :news_index, :video_index, :press_index]
  caches_page :index, :blog_index, :blog_show, :news_index, :news_show, :video_index, :press_index

  def index
    @render_footer = false
    set_page_metadata(:media)
    initialize_locale_links

    @header_h1 = I18n.t("media.header")
    @show_header_h1 = true
  end

  def blog_index
    @category = "blog"
    init_articles(BlogArticle)
    set_page_metadata(:media_blog)
    initialize_locale_links
  end

  def blog_show
    @article = BlogArticle.get(params[:id])
    if @article.nil?
      return render_not_found
    end

    @og_image = @article.avatar.url(:list)

    @shareable_resource = @article
    set_page_metadata(@article)
    initialize_locale_links
    add_breadcrumb(@article.name, @article.url, nil, true, "components.breadcrumbs", "-")

    @prev = @article.prev(blog_articles_collection)
    @next = @article.next(blog_articles_collection)
  end

  def news_index
    @category = "news"
    init_articles(NewsArticle)
    set_page_metadata(:media_news)
    initialize_locale_links
  end

  def news_show
    @article = NewsArticle.get(params[:id])
    if @article.nil?
      return render_not_found
    end

    @shareable_resource = @article
    set_page_metadata(@article)
    initialize_locale_links
    add_breadcrumb(@article.name, @article.url, nil, true, "components.breadcrumbs", "-")

    @prev = @article.prev(news_articles_collection, count: 2)
    @next = @article.next(news_articles_collection, count: 2)
    @related_articles = @prev + @next
  end

  def video_index
    @category = "video"
    set_page_metadata(:media_video)
    initialize_locale_links
    add_breadcrumb(:media_video, media_video_path)
    @videos = MediaVideo.published
    @items_per_page = 10

    @filtered_videos = filter_by_tags(@videos)
    @paginated_entries = get_paginated_entries(@videos, @items_per_page)

    @total_pages = (@videos.count.to_f / @items_per_page).ceil
    @filtered_pages = (@filtered_videos.count.to_f / @items_per_page).ceil
  end

  def press_index
    @category = "press"
    add_breadcrumb(:media_press, media_press_path)
    set_page_metadata(:media_press)
    initialize_locale_links

    @press_entries = MediaPressEntry.published
    @items_per_page = 10

    @paginated_entries = get_paginated_entries(@press_entries, @items_per_page)

    @total_pages = (@press_entries.count.to_f / @items_per_page).ceil
    @filtered_pages = @total_pages
  end

  private
  def set_featured_articles
    @featured_articles = BlogArticle.media_featured
  end

  def add_media_breadcrumb
    add_breadcrumb(:media, media_path)
  end

  def add_blog_breadcrumb
    add_breadcrumb(:media_blog, media_blog_path)
  end

  def add_news_breadcrumb
    add_breadcrumb(:media_news, media_news_path)
  end

  def blog_articles_collection
    @articles ||= BlogArticle.published
  end

  def news_articles_collection
    @articles ||= NewsArticle.published
  end

  def init_articles(klass)
    send("#{klass.name.underscore.pluralize}_collection")
    association_name = klass.name.underscore.pluralize.to_sym
    table_name = klass.table_name
    @items_per_page = 10

    @selected_tags_url_fragments = (params[:tags] || "").split(",")
    @filtered_articles = filter_by_tags(@articles)
    @paginated_entries = @paginated_articles = get_paginated_entries(@filtered_articles, @items_per_page)

    @total_pages = (@articles.count.to_f / @items_per_page).ceil
    @filtered_pages = (@filtered_articles.count.to_f / @items_per_page).ceil

    @tags = Cms::Tag.all.joins(association_name).where(:"#{table_name}" => { published: "t" }).includes(:translations, :taggings, association_name)
  end

end