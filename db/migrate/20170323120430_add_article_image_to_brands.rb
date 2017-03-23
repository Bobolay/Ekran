class AddArticleImageToBrands < ActiveRecord::Migration
  def change
    change_table :brands do |t|
      t.attachment :article_image
    end
  end
end
