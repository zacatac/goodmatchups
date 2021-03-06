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

ActiveRecord::Schema.define(version: 20141125190112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "divisions", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
  end

  add_index "divisions", ["name"], name: "index_divisions_on_name", unique: true, using: :btree

  create_table "stats", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
    t.integer  "division_id"
  end

  add_index "stats", ["division_id"], name: "index_stats_on_division_id", using: :btree

  create_table "teams", force: true do |t|
    t.string   "name",        null: false
    t.integer  "win"
    t.integer  "loss"
    t.integer  "division_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "label"
  end

  add_index "teams", ["division_id"], name: "index_teams_on_division_id", using: :btree
  add_index "teams", ["name"], name: "index_teams_on_name", unique: true, using: :btree

end
