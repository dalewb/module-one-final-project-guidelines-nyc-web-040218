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

ActiveRecord::Schema.define(version: 5) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "open_price"
    t.string "close_price"
    t.string "percent_change"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.boolean "buy"
    t.integer "num_of_shares"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.integer "account_balance"
  end

end
