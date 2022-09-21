class CreateRewards < ActiveRecord::Migration
  def up
    create_table :rewards do |t|
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :rewards
  end
end
