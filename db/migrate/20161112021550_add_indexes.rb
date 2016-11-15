class AddIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :books, :status
    add_index :books, :finished_on
  end
end
