class CreateOffices < ActiveRecord::Migration
  def up
    create_table :offices do |t|
      t.boolean :published
      t.integer :sorting_position
      t.string :name
      t.string :city
      t.text :address
      t.text :phones
      t.text :emails
      t.text :fax_phones
      t.text :working_hours
      t.string :lat_lng
      t.string :google_map_url

      t.timestamps null: false
    end

    Office.create_translation_table(:name, :city, :address, :working_hours, :google_map_url)
  end

  def down
    Office.drop_translation_table!

    drop_table :offices
  end
end
