class CreatePartnershipRequests < ActiveRecord::Migration
  def change
    create_table :partnership_requests do |t|
      t.string :role
      t.string :name
      t.string :email
      t.string :phone
      t.text :comment
      t.string :referer
      t.string :session_id

      t.timestamps null: false
    end
  end
end
