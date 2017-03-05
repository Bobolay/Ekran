class CreatePartnershipArticles < ActiveRecord::Migration
  def up
    create_table :partnership_articles do |t|
      t.boolean :published
      t.integer :sorting_position
      t.attachment :list_item_image
      t.string :list_item_title
      t.string :name
      t.string :url_fragment
      t.attachment :avatar
      t.string :banner_title
      t.text :content
      t.text :phones
      t.text :emails


      t.timestamps null: false
    end

    PartnershipArticle.create_translation_table(:list_item_title, :name, :url_fragment, :banner_title, :content)
  end

  def down
    PartnershipArticle.drop_translation_table!

    drop_table :partnership_articles
  end
end
