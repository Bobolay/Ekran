class CreateVacancies < ActiveRecord::Migration
  def up
    create_table :vacancies do |t|
      t.integer :office_id
      t.string :contract_type
      t.string :position
      t.integer :sorting_position
      t.string :salary
      t.text :content

      t.timestamps null: false
    end

    Vacancy.create_translation_table(:salary, :position, :content)
  end

  def down
    Vacancy.drop_translation_table!

    drop_table :vacancies
  end
end
