class CreateTransactions < ActiveRecord::Migration
  def up
    create_table :transactions do |t|
      t.integer :user_id
      t.decimal :amount
      t.string :currency
      t.string :transaction_type
      t.string :status
      t.text :note

      t.timestamps
    end

    add_index :transactions, [:user_id, :created_at]
  end

  def down
    drop_table :transactions
  end
end
