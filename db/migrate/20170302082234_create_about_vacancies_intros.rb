class CreateAboutVacanciesIntros < ActiveRecord::Migration
  def up
    create_table :about_vacancies_intros do |t|
      t.text :content

      t.timestamps null: false
    end

    AboutVacanciesIntro.create_translation_table(:content)
  end

  def down
    AboutVacanciesIntro.drop_translation_table!

    drop_table :about_vacancies_intros
  end
end
