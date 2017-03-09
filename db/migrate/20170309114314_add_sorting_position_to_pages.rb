class AddSortingPositionToPages < ActiveRecord::Migration
  def change
    add_column :pages, :sorting_position, :integer
  end
end
