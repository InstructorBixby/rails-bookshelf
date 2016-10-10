class AddUserToBooks < ActiveRecord::Migration
  def up
    add_column :books, :user_id, :integer
    add_index :books, :user_id
    # everything already in there is mine
    first = User.order(:id).first
    Book.update_all(user_id: first.id) if first
  end

  def down
    remove_column :books, :user_id
  end
end
