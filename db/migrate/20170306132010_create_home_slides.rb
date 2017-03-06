class CreateHomeSlides < ActiveRecord::Migration
  def up
    create_table :home_slides do |t|
      t.boolean :published
      t.integer :sorting_position
      t.attachment :image
      t.string :image_alt
      t.text :description

      t.timestamps null: false
    end

    HomeSlide.create_translation_table(:image_alt, :description)
  end

  def down
    HomeSlide.drop_translation_table!

    drop_table :home_slides
  end
end
