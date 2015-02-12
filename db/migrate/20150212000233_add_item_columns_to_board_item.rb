class AddItemColumnsToBoardItem < ActiveRecord::Migration
  def change
  	add_column :board_items, :note_item_id, :integer
  	add_column :board_items, :file_item_id, :integer
  end
end
