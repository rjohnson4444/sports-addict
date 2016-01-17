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

ActiveRecord::Schema.define(version: 20160116043814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string   "name"
    t.integer  "conference_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "divisions", ["conference_id"], name: "index_divisions_on_conference_id", using: :btree

  create_table "favorite_teams", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.integer  "division_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
  end

  add_index "favorite_teams", ["division_id"], name: "index_favorite_teams_on_division_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "profile_image"
    t.string   "description"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "favorite_team_id"
  end

  add_index "users", ["favorite_team_id"], name: "index_users_on_favorite_team_id", using: :btree

  add_foreign_key "divisions", "conferences"
  add_foreign_key "favorite_teams", "divisions"
  add_foreign_key "users", "favorite_teams"
end
