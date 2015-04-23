class ReadOnlyBoards < ActiveRecord::Migration
  def change
    add_column :boards, :readonly, :boolean, default: false
  end
end
