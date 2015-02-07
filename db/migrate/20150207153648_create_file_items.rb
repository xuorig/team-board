class CreateFileItems < ActiveRecord::Migration
  def change
    create_table :file_items do |t|
      t.string :file_url

      t.timestamps null: false
    end
  end
end
