class DropTableManagerProjects < ActiveRecord::Migration
  def change
  	drop_table :manager_projects
  end
end
