class CreateBoardItems < ActiveRecord::Migration
  def change
    create_table :board_items do |t|
      t.integer :position
      t.string :color
      t.string :title

      t.timestamps null: false
    end
  end
end
