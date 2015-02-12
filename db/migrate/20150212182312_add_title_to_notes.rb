class AddTitleToNotes < ActiveRecord::Migration
  def change
  	add_column :board_items, :note_title, :string
  end
end
