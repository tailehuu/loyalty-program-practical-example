class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :dob
      t.integer :point,   default: 0
      t.string :tier,     default: 'standard'
      t.string :currency, default: 'USD'

      t.timestamps
    end

    add_index :users, :created_at
    add_index :users, :dob
  end

  def down
    drop_table :users
  end
end
