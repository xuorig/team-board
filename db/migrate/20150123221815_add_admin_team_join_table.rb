class AddAdminTeamJoinTable < ActiveRecord::Migration
  def change
    create_table :admins_teams do |t|
      t.references :user, index: true
      t.references :team, index: true

      t.timestamps
    end
  end
end
