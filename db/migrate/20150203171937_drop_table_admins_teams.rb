class DropTableAdminsTeams < ActiveRecord::Migration
  def change
    drop_table :admins_teams
  end
end
