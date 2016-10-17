class AddStatusToBooks < ActiveRecord::Migration[4.2]
  def change
    add_column :books, :status, :string, default: 'unread'
  end
end
