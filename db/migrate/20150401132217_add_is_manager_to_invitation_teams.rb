class AddIsManagerToInvitationTeams < ActiveRecord::Migration
  def change
    add_column :invitation_teams, :as_manager, :boolean, :default => false
  end
end
