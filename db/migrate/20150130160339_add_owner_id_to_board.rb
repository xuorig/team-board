class AddOwnerIdToBoard < ActiveRecord::Migration
  def change
  	add_column :boards, :owner_id, :integer
  end
end
