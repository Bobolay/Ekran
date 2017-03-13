class AddShortDescriptionToProject < ActiveRecord::Migration
  def change
    add_column :projects, :short_description, :text
    add_column :project_translations, :short_description, :text
  end
end
