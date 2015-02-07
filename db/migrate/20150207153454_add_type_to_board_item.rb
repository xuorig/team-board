class AddTypeToBoardItem < ActiveRecord::Migration
  def change
  	add_column :board_items, :type, :string
  end
end
