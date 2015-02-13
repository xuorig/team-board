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

ActiveRecord::Schema.define(version: 20150212182312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins_projects", ["project_id"], name: "index_admins_projects_on_project_id", using: :btree
  add_index "admins_projects", ["user_id"], name: "index_admins_projects_on_user_id", using: :btree

  create_table "board_items", force: :cascade do |t|
    t.integer  "position"
    t.string   "color"
    t.string   "title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "type"
    t.integer  "note_item_id"
    t.integer  "file_item_id"
    t.string   "note_content"
    t.integer  "board_id"
    t.integer  "ui_column"
    t.string   "note_title"
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "color"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "project_id"
    t.integer  "owner_id"
  end

  create_table "file_items", force: :cascade do |t|
    t.string   "file_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manager_projects", force: :cascade do |t|
    t.integer  "manager_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "managerships", force: :cascade do |t|
    t.integer  "manager_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "note_items", force: :cascade do |t|
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "owner_id"
    t.integer  "team_id"
  end

  create_table "projects_users", id: false, force: :cascade do |t|
    t.integer "user_id",    null: false
    t.integer "project_id", null: false
  end

  add_index "projects_users", ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id", using: :btree
  add_index "projects_users", ["user_id", "project_id"], name: "index_projects_users_on_user_id_and_project_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "string"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "owner_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "email"
    t.boolean  "active",           default: false
  end

end
