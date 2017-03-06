class CreateBrands < ActiveRecord::Migration
  def up
    create_table :brands do |t|
      t.boolean :published
      t.boolean :featured
      t.integer :sorting_position
      t.string :name
      t.text :short_description
      t.attachment :bg_svg_icon
      t.attachment :svg_icon
      t.attachment :image
      t.string :brand_url

      t.timestamps null: false
    end

    Brand.create_translation_table(:name, :short_description, :brand_url)
  end

  def down
    Brand.drop_translation_table!

    drop_table :brands
  end
end
