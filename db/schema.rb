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

ActiveRecord::Schema.define(version: 20141122210842) do

  create_table "area_schedules", force: true do |t|
    t.integer  "schedule_id"
    t.integer  "area_id"
    t.string   "monday_outtages"
    t.string   "tuesday_outtages"
    t.string   "wednesday_outtages"
    t.string   "thursday_outtages"
    t.string   "friday_outtages"
    t.string   "saturday_outtages"
    t.string   "sunday_outtages"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas", force: true do |t|
    t.string   "name"
    t.string   "long_name",  default: ""
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.string   "long_name",          default: ""
    t.boolean  "is_load_shedding",   default: false
    t.integer  "active_schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
