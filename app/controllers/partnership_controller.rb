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
  end

  private
  def add_partnership_breadcrumb
    add_breadcrumb(:partnership, partnership_path)
  end
end