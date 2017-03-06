class AddHomeSlideNameToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :home_slide_name, :string
    add_column :brand_translations, :home_slide_name, :string
  end
end
