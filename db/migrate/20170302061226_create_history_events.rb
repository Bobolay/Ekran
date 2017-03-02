class CreateHistoryEvents < ActiveRecord::Migration
  def up
    create_table :history_events do |t|
      t.boolean :published
      t.string :name
      t.text :short_description
      t.date :date

      t.timestamps null: false
    end

    HistoryEvent.create_translation_table(:name, :short_description)
  end

  def down
    HistoryEvent.drop_translation_table!

    drop_table :history_events
  end
end
