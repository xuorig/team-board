class AddBoardIdToBoardItem < ActiveRecord::Migration
  def change
  	add_column :board_items, :board_id, :integer
  end
end
