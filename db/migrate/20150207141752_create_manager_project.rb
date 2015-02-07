class CreateManagerProject < ActiveRecord::Migration
  def change
    create_table :manager_projects do |t|
      t.integer :manager_id
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
