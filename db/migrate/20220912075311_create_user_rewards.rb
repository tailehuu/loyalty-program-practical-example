class CreateUserRewards < ActiveRecord::Migration
  def up
    create_table :user_rewards do |t|
      t.integer :user_id
      t.integer :reward_id
      t.string :status

      t.timestamps
    end

    add_index :user_rewards, [:user_id, :reward_id]
  end

  def down
    drop_table :user_rewards
  end
end
