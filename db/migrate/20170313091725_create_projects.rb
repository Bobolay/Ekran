class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.boolean :published
      t.string :name
      t.string :url_fragment
      t.date :date
      t.integer :brand_id
      t.attachment :image
      t.text :content
      t.string :client
      t.string :address


      t.timestamps null: false
    end

    Project.create_translation_table(:name, :url_fragment, :content, :client, :address)
  end

  def down
    Project.drop_translation_table!

    drop_table :projects
  end
end
