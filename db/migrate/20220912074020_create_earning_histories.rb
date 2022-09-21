class CreateEarningHistories < ActiveRecord::Migration
  def up
    create_table :earning_histories do |t|
      t.integer :user_id
      t.integer :point
      t.text :note

      t.timestamps
    end

    add_index :earning_histories, [:user_id, :created_at]
  end

  def down
    drop_table :earning_histories
  end
end
