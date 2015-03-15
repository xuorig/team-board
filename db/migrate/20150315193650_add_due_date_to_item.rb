class AddDueDateToItem < ActiveRecord::Migration
  def change
    add_column :board_items, :due_date, :datetime
  end
end
