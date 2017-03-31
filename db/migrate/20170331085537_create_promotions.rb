class CreatePromotions < ActiveRecord::Migration
  def up
    create_table :promotions do |t|
      t.boolean :published
      t.date :start_date
      t.date :end_date
      t.attachment :avatar
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
