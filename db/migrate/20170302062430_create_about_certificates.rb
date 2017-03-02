class CreateAboutCertificates < ActiveRecord::Migration
  def up
    create_table :about_certificates do |t|
      t.string :name
      t.date :date
      t.attachment :image
      t.boolean :published

      t.timestamps null: false
    end

    AboutCertificate.create_translation_table(:name)
  end

  def down
    AboutCertificate.drop_translation_table!

    drop_table :about_certificates
  end
end
