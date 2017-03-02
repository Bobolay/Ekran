class CreateAboutSlides < ActiveRecord::Migration
  def up
    create_table :about_slides do |t|
      t.attachment :image
      t.boolean :published
      t.boolean :sorting_position
      t.string :image_alt

      t.timestamps null: false
    end

    AboutSlide.create_translation_table(:image_alt)
  end

  def down
    AboutSlide.drop_translation_table!

    drop_table :about_slides
  end
end
