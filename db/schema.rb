# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20220912075311) do

  create_table "points", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "point"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "points", ["user_id", "created_at"], name: "index_points_on_user_id_and_created_at"

  create_table "rewards", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount"
    t.string   "currency"
    t.string   "transaction_type"
    t.string   "status"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["user_id", "created_at"], name: "index_transactions_on_user_id_and_created_at"

  create_table "user_rewards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reward_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_rewards", ["user_id", "reward_id"], name: "index_user_rewards_on_user_id_and_reward_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "dob"
    t.integer  "point",      default: 0
    t.string   "tier",       default: "standard"
    t.string   "currency",   default: "USD"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["created_at"], name: "index_users_on_created_at"
  add_index "users", ["dob"], name: "index_users_on_dob"

end
