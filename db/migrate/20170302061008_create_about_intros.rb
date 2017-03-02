class CreateAboutIntros < ActiveRecord::Migration
  def up
    create_table :about_intros do |t|
      t.text :content

      t.timestamps null: false
    end

    AboutIntro.create_translation_table(:content)
  end

  def down
    AboutIntro.drop_translation_table!

    drop_table :about_intros
  end
end
