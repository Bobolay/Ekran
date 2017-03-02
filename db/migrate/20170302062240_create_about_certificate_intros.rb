class CreateAboutCertificateIntros < ActiveRecord::Migration
  def up
    create_table :about_certificate_intros do |t|
      t.text :content

      t.timestamps null: false
    end

    AboutCertificateIntro.create_translation_table(:content)
  end

  def down
    AboutCertificateIntro.drop_translation_table!

    drop_table :about_certificate_intros
  end
end
