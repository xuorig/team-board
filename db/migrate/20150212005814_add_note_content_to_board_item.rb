class AddNoteContentToBoardItem < ActiveRecord::Migration
  def change
  	add_column :board_items, :note_content, :string
  end
end
