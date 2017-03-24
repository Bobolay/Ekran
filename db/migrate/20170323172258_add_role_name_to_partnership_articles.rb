class AddRoleNameToPartnershipArticles < ActiveRecord::Migration
  def change
    add_column :partnership_articles, :role_name, :string
    add_column :partnership_article_translations, :role_name, :string
  end
end
