class AddUrbanTypeSettlementToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :urban_type_settlement, :string
    add_column :office_translations, :urban_type_settlement, :string
  end
end
