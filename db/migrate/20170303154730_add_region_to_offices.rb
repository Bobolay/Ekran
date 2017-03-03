class AddRegionToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :region, :string
    add_column :office_translations, :region, :string
  end
end
