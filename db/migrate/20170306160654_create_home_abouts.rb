class CreateHomeAbouts < ActiveRecord::Migration
  def change
    create_table :home_abouts do |t|

      t.timestamps null: false
    end
  end
end