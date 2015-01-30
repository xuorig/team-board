class AddProjectIdToBoard < ActiveRecord::Migration
  def change
  	add_column :boards, :project_id, :integer
  end
end
