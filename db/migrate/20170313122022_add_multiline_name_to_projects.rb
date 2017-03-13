class AddMultilineNameToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :multiline_name, :string
    add_column :project_translations, :multiline_name, :string
  end
end
