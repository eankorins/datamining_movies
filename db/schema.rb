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

ActiveRecord::Schema.define(version: 20150406133007) do

  create_table "genres", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "movie_tags", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.string   "tag",        limit: 255
    t.datetime "timestamp"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "imdb_id",    limit: 4
    t.integer  "tmdb_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "movie_id",   limit: 4
    t.decimal  "rating",               precision: 10
    t.datetime "timestamp"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
