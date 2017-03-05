class CreatePartnershipTexts < ActiveRecord::Migration
  def up
    create_table :partnership_texts do |t|
      t.text :content

      t.timestamps null: false
    end

    PartnershipText.create_translation_table(:content)
  end

  def down
    PartnershipText.drop_translation_table!

    drop_table :partnership_texts
  end
end
