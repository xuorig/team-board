class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :board_item_id
      t.integer :assignee_id

      t.timestamps null: false
    end
  end
end
