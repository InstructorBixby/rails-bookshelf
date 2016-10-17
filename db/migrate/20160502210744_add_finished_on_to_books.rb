class AddFinishedOnToBooks < ActiveRecord::Migration[4.2]
  def change
    add_column :books, :finished_on, :date
  end
end
