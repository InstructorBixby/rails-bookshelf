class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end
    add_index :tags, :name, unique: true

    create_table :book_tags do |t|
      t.integer :book_id
      t.integer :tag_id
    end
    add_index :book_tags, [:book_id, :tag_id], unique: true
  end
end
