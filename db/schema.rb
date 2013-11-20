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

ActiveRecord::Schema.define(version: 20131119170746) do

  create_table "algorithms", force: true do |t|
    t.string   "name"
    t.string   "input"
    t.string   "output"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "element_match_elements", force: true do |t|
    t.integer "element_id"
    t.integer "match_id"
  end

  add_index "element_match_elements", ["element_id"], name: "index_element_match_elements_on_element_id", using: :btree
  add_index "element_match_elements", ["match_id"], name: "index_element_match_elements_on_match_id", using: :btree

  create_table "elements", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pattern"
  end

  create_table "expressions", force: true do |t|
    t.string   "name"
    t.string   "key"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "helper"
  end

  create_table "functions", force: true do |t|
    t.string   "name"
    t.string   "pattern"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

  create_table "operators", force: true do |t|
    t.string   "name"
    t.string   "display_name"
    t.string   "pattern"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "structures", force: true do |t|
    t.integer  "formattable_id"
    t.string   "formattable_type"
    t.string   "pattern"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
