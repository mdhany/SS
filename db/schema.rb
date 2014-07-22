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

ActiveRecord::Schema.define(version: 20140711183714) do

  create_table "admin_pages", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "capacities", force: true do |t|
    t.string   "name",       default: "beginner"
    t.string   "status",     default: "inactive"
    t.integer  "capacity",   default: 1
    t.integer  "level_id",   default: 1
    t.integer  "login_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "amount"
  end

  create_table "logins", force: true do |t|
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
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "identification"
    t.string   "phone"
    t.string   "mobile"
    t.integer  "number_account"
    t.string   "account_type"
    t.string   "status"
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.string   "address"
    t.integer  "level_id",               default: 1
    t.integer  "role_id"
    t.integer  "sponsor_id"
    t.string   "paypal"
    t.string   "skype"
    t.string   "avatar"
  end

  add_index "logins", ["email"], name: "index_logins_on_email", unique: true, using: :btree
  add_index "logins", ["identification"], name: "index_logins_on_identification", unique: true, using: :btree
  add_index "logins", ["number_account"], name: "index_logins_on_number_account", unique: true, using: :btree
  add_index "logins", ["reset_password_token"], name: "index_logins_on_reset_password_token", unique: true, using: :btree
  add_index "logins", ["username"], name: "index_logins_on_username", unique: true, using: :btree

  create_table "logins_payments", force: true do |t|
    t.integer "payment_id"
    t.integer "login_id"
  end

  create_table "managers", force: true do |t|
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

  add_index "managers", ["email"], name: "index_managers_on_email", unique: true, using: :btree
  add_index "managers", ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.text     "message"
    t.integer  "uSent_ID"
    t.integer  "uReceived_ID"
    t.integer  "login_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.boolean  "read",       default: false
    t.string   "message"
    t.string   "link"
    t.integer  "login_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: true do |t|
    t.integer  "amount"
    t.boolean  "sent",           default: false
    t.boolean  "received",       default: false
    t.text     "gateway"
    t.integer  "turn_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "level_id",       default: 1
    t.string   "receipt"
    t.integer  "login_id",                       null: false
    t.integer  "beneficiary_id",                 null: false
    t.text     "comment"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "turns", force: true do |t|
    t.integer  "login_id"
    t.integer  "level_id",   default: 1
    t.string   "status",     default: "waiting"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "referred"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "country"
    t.string   "city"
    t.string   "state"
    t.string   "address"
    t.integer  "level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "identification",        limit: 8
    t.integer  "phone"
    t.integer  "mobile"
    t.integer  "number_account"
    t.string   "account_type"
    t.string   "password_confirmation"
    t.string   "status"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["identification"], name: "index_users_on_identification", unique: true, using: :btree
  add_index "users", ["number_account"], name: "index_users_on_number_account", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
