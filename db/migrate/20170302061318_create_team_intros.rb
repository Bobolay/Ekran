class CreateTeamIntros < ActiveRecord::Migration
  def up
    create_table :team_intros do |t|
      t.text :content

      t.timestamps null: false
    end

    TeamIntro.create_translation_table(:content)
  end

  def down
    TeamIntro.drop_translation_table!

    drop_table :team_intros
  end
end
