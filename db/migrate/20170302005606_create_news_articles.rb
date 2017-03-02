class CreateNewsArticles < ActiveRecord::Migration
  def up
    create_table :news_articles do |t|
      t.boolean :published
      t.string :name
      t.string :url_fragment
      t.text :short_description
      t.text :content
      t.datetime :release_date

      t.timestamps null: false
    end

    NewsArticle.create_translation_table(:name, :url_fragment, :short_description, :content)
  end

  def down
    NewsArticle.drop_translation_table!

    drop_table :news_articles
  end
end
