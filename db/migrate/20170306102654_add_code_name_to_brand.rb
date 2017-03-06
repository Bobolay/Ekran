class AddCodeNameToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :code_name, :string
  end
end
