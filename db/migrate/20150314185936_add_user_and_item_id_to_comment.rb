class AddUserAndItemIdToComment < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :board_item_id, :integer
  end
end
