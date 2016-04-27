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

ActiveRecord::Schema.define(version: 20160427080955) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "project_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.boolean  "admin",                default: false
    t.integer  "creator_id", limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content",     limit: 255
    t.string   "source_type", limit: 255
    t.integer  "source_id",   limit: 4
    t.integer  "creator_id",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "team_id",     limit: 4
    t.integer  "project_id",  limit: 4
    t.integer  "user_id",     limit: 4
    t.string   "source_type", limit: 255
    t.integer  "source_id",   limit: 4
    t.string   "behaviour",   limit: 255
    t.string   "message",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "project_id",  limit: 4
    t.integer  "creator_id",  limit: 4
    t.integer  "updater_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "team_id",     limit: 4
    t.integer  "creator_id",  limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "team_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "team_id",    limit: 4
    t.boolean  "admin",                default: false
    t.integer  "creator_id", limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "creator_id", limit: 4
    t.integer  "updater_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "assignee_id", limit: 4
    t.date     "due_date"
    t.integer  "finisher_id", limit: 4
    t.datetime "finished_at"
    t.integer  "project_id",  limit: 4
    t.integer  "list_id",     limit: 4
    t.integer  "creator_id",  limit: 4
    t.integer  "updater_id",  limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "avatar_url", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
