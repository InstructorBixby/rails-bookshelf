class AddCoverUrlToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :cover_url, :string
  end
end
