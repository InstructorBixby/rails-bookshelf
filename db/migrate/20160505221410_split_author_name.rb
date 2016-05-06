class SplitAuthorName < ActiveRecord::Migration
  def up
    add_column :books, :author_first, :string
    add_column :books, :author_last, :string
    Book.reset_column_information
    Book.find_each do |b|
      parts = b.author.to_s.split(' ')
      b.author_last = parts.pop
      b.author_first = parts.join(' ')
      b.save(validate: false)
    end
  end

  def down
    remove_column :books, :author_first
    remove_column :books, :author_last
  end
end
