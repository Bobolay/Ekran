class AddFeaturedToPartnershipArticles < ActiveRecord::Migration
  def change
    add_column :partnership_articles, :featured, :boolean
  end
end
