class AddFieldsToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :content, :text
    add_column :brands, :url_fragment, :string

    add_column :brand_translations, :content, :text
    add_column :brand_translations, :url_fragment, :string
  end
end
