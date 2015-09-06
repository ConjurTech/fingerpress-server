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

ActiveRecord::Schema.define(version: 20150906151002) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "sex",         limit: 255
    t.datetime "birthdate"
    t.datetime "joindate"
    t.datetime "leavedate"
    t.string   "bankdetails", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pay_schemes", force: :cascade do |t|
    t.integer  "pay_type_id",        limit: 4
    t.float    "pay",                limit: 24
    t.float    "pay_ot",             limit: 24
    t.float    "pay_public_holiday", limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "pay_schemes", ["pay_type_id"], name: "index_pay_schemes_on_pay_type_id", using: :btree

  create_table "pay_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "payment_record_pay_schemes", force: :cascade do |t|
    t.integer  "pay_type_id",        limit: 4
    t.float    "pay",                limit: 24
    t.float    "pay_ot",             limit: 24
    t.float    "pay_public_holiday", limit: 24
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "payment_record_pay_schemes", ["pay_type_id"], name: "index_payment_record_pay_schemes_on_pay_type_id", using: :btree

  create_table "payment_record_time_logs", force: :cascade do |t|
    t.datetime "date_time_in"
    t.datetime "date_time_out"
    t.integer  "payment_record_pay_scheme_id", limit: 4
    t.integer  "payment_record_id",            limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "payment_record_time_logs", ["payment_record_id"], name: "index_payment_record_time_logs_on_payment_record_id", using: :btree
  add_index "payment_record_time_logs", ["payment_record_pay_scheme_id"], name: "index_payment_record_time_logs_on_payment_record_pay_scheme_id", using: :btree

  create_table "payment_records", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.float    "total_pay",   limit: 24
    t.float    "bonus",       limit: 24
    t.datetime "paid_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "paid",        limit: 1,  default: false
  end

  add_index "payment_records", ["employee_id"], name: "index_payment_records_on_employee_id", using: :btree

  create_table "time_logs", force: :cascade do |t|
    t.datetime "date_time_in"
    t.datetime "date_time_out"
    t.integer  "employee_id",       limit: 4
    t.integer  "pay_scheme_id",     limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "payment_record_id", limit: 4
  end

  add_index "time_logs", ["employee_id"], name: "index_time_logs_on_employee_id", using: :btree
  add_index "time_logs", ["pay_scheme_id"], name: "index_time_logs_on_pay_scheme_id", using: :btree
  add_index "time_logs", ["payment_record_id"], name: "index_time_logs_on_payment_record_id", using: :btree

  add_foreign_key "pay_schemes", "pay_types"
  add_foreign_key "payment_record_pay_schemes", "pay_types"
  add_foreign_key "payment_record_time_logs", "payment_record_pay_schemes"
  add_foreign_key "payment_record_time_logs", "payment_records"
  add_foreign_key "payment_records", "employees"
  add_foreign_key "time_logs", "employees"
  add_foreign_key "time_logs", "pay_schemes"
  add_foreign_key "time_logs", "payment_records"
end
