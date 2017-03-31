class CreatePromotions < ActiveRecord::Migration
  def up
    create_table :promotions do |t|
      t.boolean :published
      t.datetime :start_date_time
      t.datetime :end_date_time
      t.attachment :avatar
      t.attachment :banner
      t.string :name
      t.string :url_fragment
      t.text :content

      t.timestamps null: false
    end

    Promotion.create_translation_table(:name, :url_fragment, :content)
  end

  def down
    Promotion.drop_translation_table!

    drop_table :promotions
  end
end
