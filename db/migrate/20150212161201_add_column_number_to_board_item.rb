class AddColumnNumberToBoardItem < ActiveRecord::Migration
  def change
  	add_column :board_items, :ui_column, :integer
  end
end
