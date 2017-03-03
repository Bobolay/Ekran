class AddUrlFragmentToVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :url_fragment, :string
    add_column :vacancy_translations, :url_fragment, :string
  end
end
