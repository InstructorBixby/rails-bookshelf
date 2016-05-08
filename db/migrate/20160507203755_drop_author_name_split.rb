# "Ursula K. Le Guin" -> first "Ursula K. Le", last "Guin" and
# "bell hooks" -> last "hooks". splitting a name on spaces does not
# work and i cannot see a rule that does, so sorting by author is
# going back to sorting by the whole string.
class DropAuthorNameSplit < ActiveRecord::Migration
  def up
    remove_column :books, :author_first
    remove_column :books, :author_last
  end

  def down
    add_column :books, :author_first, :string
    add_column :books, :author_last, :string
  end
end
