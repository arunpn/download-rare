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

ActiveRecord::Schema.define(version: 20140302083520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "movies", force: true do |t|
    t.string   "title"
    t.integer  "tmdb_id"
    t.string   "poster"
    t.string   "backdrop"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.tsvector "tsv"
    t.string   "slug"
  end

  add_index "movies", ["slug"], name: "index_movies_on_slug", unique: true, using: :btree
  add_index "movies", ["tmdb_id"], name: "index_movies_on_tmdb_id", unique: true, using: :btree
  add_index "movies", ["tsv"], name: "movies_tsv_idx", using: :gin

  create_table "tv_shows", force: true do |t|
    t.string   "name"
    t.integer  "tmdb_id"
    t.string   "poster"
    t.string   "backdrop"
    t.date     "release_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.tsvector "tsv"
    t.string   "slug"
  end

  add_index "tv_shows", ["slug"], name: "index_tv_shows_on_slug", unique: true, using: :btree
  add_index "tv_shows", ["tmdb_id"], name: "index_tv_shows_on_tmdb_id", unique: true, using: :btree
  add_index "tv_shows", ["tsv"], name: "tv_shows_tsv_idx", using: :gin

end