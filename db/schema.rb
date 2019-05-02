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

ActiveRecord::Schema.define(version: 20190502192419) do

  create_table "days", force: :cascade do |t|
    t.date     "date"
    t.integer  "travel_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "days", ["travel_id"], name: "index_days_on_travel_id"

  create_table "events", force: :cascade do |t|
    t.string   "category"
    t.string   "name"
    t.string   "address"
    t.datetime "starting_time"
    t.datetime "ending_time"
    t.float    "pricing"
    t.string   "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "day_id"
  end

  add_index "events", ["day_id"], name: "index_events_on_day_id"

  create_table "travels", force: :cascade do |t|
    t.string   "name"
    t.string   "destination"
    t.datetime "init_date"
    t.datetime "final_date"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
