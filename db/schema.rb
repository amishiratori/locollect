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

ActiveRecord::Schema.define(version: 20160625054619) do

  create_table "maps", force: :cascade do |t|
    t.string   "name"
    t.string   "map_name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "good",       default: 0
    t.string   "stores"
    t.integer  "station_id"
  end

  create_table "maps_stores", id: false, force: :cascade do |t|
    t.integer "map_id",   null: false
    t.integer "store_id", null: false
  end

  add_index "maps_stores", ["map_id"], name: "index_maps_stores_on_map_id"
  add_index "maps_stores", ["store_id"], name: "index_maps_stores_on_store_id"

  create_table "stations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "address"
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
