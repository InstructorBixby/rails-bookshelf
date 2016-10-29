class CreateNotes < ActiveRecord::Migration[5.0]
  def change
    create_table :notes do |t|
      t.integer :book_id
      t.text :body
      t.integer :page

      t.timestamps
    end
    add_index :notes, :book_id
  end
end
