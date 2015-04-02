class CreateInvitationTeams < ActiveRecord::Migration
  def change
    create_table :invitation_teams do |t|
      t.timestamps null: false
      t.integer :team_id
      t.integer :invitation_id
    end
  end
end
