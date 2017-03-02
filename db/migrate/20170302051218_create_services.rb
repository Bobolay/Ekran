class CreateServices < ActiveRecord::Migration
  def up
    create_table :services do |t|
      t.boolean :published
      t.integer :sorting_position
      t.string :name
      t.string :url_fragment
      t.text :short_description
      t.attachment :large_image
      t.attachment :avatar
      t.string :banner_title
      t.text :content

      t.timestamps null: false
    end

    Service.create_translation_table(:name, :url_fragment, :short_description, :banner_title, :content)
  end

  def down
    Service.drop_translation_table!

    drop_table :services
  end
end
