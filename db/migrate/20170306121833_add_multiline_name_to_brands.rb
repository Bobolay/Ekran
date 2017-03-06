class AddMultilineNameToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :multiline_name, :string
    add_column :brand_translations, :multiline_name, :string
  end
end
