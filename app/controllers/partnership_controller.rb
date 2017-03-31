class PartnershipController < ApplicationController
  before_action :add_partnership_breadcrumb

  def index
    set_page_metadata(:partnership)
    @partnership_text = PartnershipText.first.try(:content)
    @articles = PartnershipArticle.published
  end

  def show
    @article = PartnershipArticle.get(params[:id])
    if @article.nil?
      return render_not_found
    end

    set_page_metadata(@article)
    add_breadcrumb(@article.name, @article.url, nil, true, "components.breadcrumbs", "-")
    @articles = PartnershipArticle.published
    @prev = @article.prev(@articles)
    @next = @article.next(@articles)

    @partnership_roles = PartnershipArticle.roles

    if @article.promotions?
      @promotions = Promotion.published
    end
  end

  def promotion
    @partnership_article = PartnershipArticle.get(params[:partnership_article_id])
    return render_not_found if @partnership_article.nil? || !@partnership_article.promotions?


    @promotion = Promotion.get(params[:id])
    return render_not_found if @promotion.blank?

    set_page_metadata(@promotion)
    add_breadcrumb(@partnership_article.name, @partnership_article.url)
    add_breadcrumb(@promotion.name, @promotion.url)

    @shareable_resource = @promotion
  end

  private
  def add_partnership_breadcrumb
    add_breadcrumb(:partnership, partnership_path)
  end
end