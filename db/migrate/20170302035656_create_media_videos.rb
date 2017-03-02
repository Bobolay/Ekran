class CreateMediaVideos < ActiveRecord::Migration
  def up
    create_table :media_videos do |t|
      t.boolean :published
      t.string :name
      t.datetime :release_date
      t.string :youtube_video_id

      t.timestamps null: false
    end

    MediaVideo.create_translation_table(:name, :youtube_video_id)
  end

  def down
    MediaVideo.drop_translation_table!

    drop_table :media_videos
  end
end
