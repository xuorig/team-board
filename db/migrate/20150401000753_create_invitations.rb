class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.timestamps null: false
      t.string :token, null: false
      t.boolean :accepted, default: false
    end
  end
end
