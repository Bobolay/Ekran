class CreateBlogArticles < ActiveRecord::Migration
  def up
    create_table :blog_articles do |t|
      t.boolean :published
      t.boolean :media_featured
      t.datetime :release_date
      t.string :name
      t.string :url_fragment
      t.string :description
      t.attachment :avatar
      t.text :content
      t.attachment :banner

      t.timestamps null: false
    end

    BlogArticle.create_translation_table(:name, :url_fragment, :description, :content)
  end

  def down
    BlogArticle.drop_translation_table!

    drop_table :blog_articles
  end
end
