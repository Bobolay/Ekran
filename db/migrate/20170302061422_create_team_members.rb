class CreateTeamMembers < ActiveRecord::Migration
  def up
    create_table :team_members do |t|
      t.boolean :published
      t.string :name
      t.string :position
      t.integer :sorting_position
      t.attachment :image

      t.timestamps null: false
    end

    TeamMember.create_translation_table(:name, :position)
  end

  def down
    TeamMember.drop_translation_table!

    drop_table :team_members
  end
end
