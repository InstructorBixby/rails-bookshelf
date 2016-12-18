class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.integer :year
      t.integer :target

      t.timestamps
    end
    add_index :goals, [:user_id, :year], unique: true
  end
end
