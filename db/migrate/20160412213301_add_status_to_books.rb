class AddStatusToBooks < ActiveRecord::Migration
  def change
    add_column :books, :status, :string, default: 'unread'
  end
end
