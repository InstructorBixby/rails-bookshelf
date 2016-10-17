class DropAuthorNameSplit < ActiveRecord::Migration[4.2]
  def up
    remove_column :books, :author_first
    remove_column :books, :author_last
  end

  def down
    add_column :books, :author_first, :string
    add_column :books, :author_last, :string
  end
end
