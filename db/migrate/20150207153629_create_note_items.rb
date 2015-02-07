class CreateNoteItems < ActiveRecord::Migration
  def change
    create_table :note_items do |t|
      t.string :content

      t.timestamps null: false
    end
  end
end
