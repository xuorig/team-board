class AddNewToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :new, :integer, :default => 0
  end
end
