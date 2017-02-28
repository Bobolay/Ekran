class MediaController < ApplicationController
  before_action :set_featured_articles, only: [:blog_index, :news_index, :video_index, :press_index]
  def index
    @render_footer = false
  end

  def blog_index
    @category = "blog"
  end

  def blog_show

  end

  def news_index
    @category = "news"
  end

  def news_show

  end

  def video_index
    @category = "video"
  end

  def press_index
    @category = "press"
  end

  private
  def set_featured_articles
    @featured_articles = BlogArticle.media_featured
  end

end