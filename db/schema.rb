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

ActiveRecord::Schema.define(version: 20141123115038) do

  create_table "areas", force: true do |t|
    t.integer  "code"
    t.string   "name"
    t.string   "long_name",  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "areas", ["code"], name: "index_areas_on_code"

  create_table "schedules", force: true do |t|
    t.integer  "stage"
    t.integer  "area"
    t.integer  "day_of_month"
    t.string   "outages"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["stage", "area", "day_of_month"], name: "schd_area_day_index", unique: true

  create_table "updates", force: true do |t|
    t.boolean  "is_load_shedding_active"
    t.integer  "stage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
