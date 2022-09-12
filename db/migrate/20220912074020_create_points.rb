class CreatePoints < ActiveRecord::Migration
  def up
    create_table :points do |t|
      t.integer :user_id
      t.integer :point
      t.text :note

      t.timestamps
    end

    add_index :points, [:user_id, :created_at]
  end

  def down
    drop_table :points
  end
end
