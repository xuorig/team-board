class CreateManagerships < ActiveRecord::Migration
  def change
    create_table :managerships do |t|
      t.integer :manager_id
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
