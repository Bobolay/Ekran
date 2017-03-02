class CreateMediaPressEntries < ActiveRecord::Migration
  def up
    create_table :media_press_entries do |t|
      t.boolean :published
      t.boolean :featured
      t.datetime :release_date
      t.string :name
      t.attachment :data

      t.timestamps null: false
    end

    MediaPressEntry.create_translation_table(:name)
  end

  def down
    MediaPressEntry.drop_translation_table!

    drop_table :media_press_entries
  end
end
