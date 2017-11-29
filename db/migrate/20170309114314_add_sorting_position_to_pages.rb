class AddSortingPositionToPages < ActiveRecord::Migration
  def up
    if !column_exists?(:pages, :sorting_position)
      add_column :pages, :sorting_position, :integer
    end
  end

  def down
    remove_column :pages, :sorting_position
  end
end
