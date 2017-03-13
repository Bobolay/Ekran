class AddShortNameToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :short_name, :string
    add_column :brand_translations, :short_name, :string
  end
end
