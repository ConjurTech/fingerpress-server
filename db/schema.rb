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

ActiveRecord::Schema.define(version: 20160212171642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "authentication_token"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "employee_pay_rolls", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "pay_roll_id"
  end

  add_index "employee_pay_rolls", ["employee_id"], name: "index_employee_pay_rolls_on_employee_id", using: :btree
  add_index "employee_pay_rolls", ["pay_roll_id"], name: "index_employee_pay_rolls_on_pay_roll_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "sex"
    t.datetime "birthdate"
    t.datetime "joindate"
    t.datetime "leavedate"
    t.string   "bankdetails"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "pay_scheme_id"
    t.string   "job"
    t.integer  "fingerprint_id"
  end

  add_index "employees", ["deleted_at"], name: "index_employees_on_deleted_at", using: :btree
  add_index "employees", ["pay_scheme_id"], name: "index_employees_on_pay_scheme_id", using: :btree

  create_table "holidays", force: :cascade do |t|
    t.date     "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "pay_rolls", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
  end

  create_table "pay_schemes", force: :cascade do |t|
    t.float    "pay"
    t.float    "pay_ot"
    t.float    "pay_public_holiday"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.float    "ot_multiplier"
    t.time     "ot_time_range_start"
    t.time     "ot_time_range_end"
    t.float    "public_holiday_multiplier"
    t.float    "pay_weekend"
    t.float    "weekend_multiplier"
    t.float    "hours_per_day"
    t.string   "pay_type"
    t.string   "ot_type"
    t.string   "weekend_type"
    t.string   "public_holiday_type"
  end

  create_table "payment_record_pay_schemes", force: :cascade do |t|
    t.float    "pay"
    t.float    "pay_ot"
    t.float    "pay_public_holiday"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name"
    t.float    "ot_multiplier"
    t.time     "ot_time_range_start"
    t.time     "ot_time_range_end"
    t.float    "public_holiday_multiplier"
    t.float    "pay_weekend"
    t.float    "weekend_multiplier"
    t.float    "hours_per_day"
    t.string   "pay_type"
    t.string   "ot_type"
    t.string   "weekend_type"
    t.string   "public_holiday_type"
  end

  create_table "payment_record_time_logs", force: :cascade do |t|
    t.datetime "date_time_in"
    t.datetime "date_time_out"
    t.integer  "payment_record_pay_scheme_id"
    t.integer  "payment_record_id"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.float    "pay"
    t.string   "remarks"
    t.boolean  "workday",                      default: false
    t.boolean  "public_holiday",               default: false
    t.string   "public_holiday_name"
    t.float    "ot_hours",                     default: 0.0
  end

  add_index "payment_record_time_logs", ["payment_record_id"], name: "index_payment_record_time_logs_on_payment_record_id", using: :btree
  add_index "payment_record_time_logs", ["payment_record_pay_scheme_id"], name: "index_payment_record_time_logs_on_payment_record_pay_scheme_id", using: :btree

  create_table "payment_records", force: :cascade do |t|
    t.integer  "employee_id"
    t.float    "total_pay"
    t.float    "bonus"
    t.datetime "paid_at"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "paid",                         default: false
    t.integer  "payment_record_pay_scheme_id"
    t.integer  "pay_roll_id"
  end

  add_index "payment_records", ["employee_id"], name: "index_payment_records_on_employee_id", using: :btree
  add_index "payment_records", ["pay_roll_id"], name: "index_payment_records_on_pay_roll_id", using: :btree
  add_index "payment_records", ["payment_record_pay_scheme_id"], name: "index_payment_records_on_payment_record_pay_scheme_id", using: :btree

  create_table "time_logs", force: :cascade do |t|
    t.datetime "date_time_in"
    t.datetime "date_time_out"
    t.integer  "employee_id"
    t.integer  "pay_scheme_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "payment_record_id"
    t.boolean  "time_log_is_valid", default: false
  end

  add_index "time_logs", ["employee_id"], name: "index_time_logs_on_employee_id", using: :btree
  add_index "time_logs", ["pay_scheme_id"], name: "index_time_logs_on_pay_scheme_id", using: :btree
  add_index "time_logs", ["payment_record_id"], name: "index_time_logs_on_payment_record_id", using: :btree

  create_table "workdays", force: :cascade do |t|
    t.string   "name"
    t.integer  "start_time_seconds"
    t.integer  "end_time_seconds"
    t.boolean  "enabled",            default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_foreign_key "employee_pay_rolls", "employees"
  add_foreign_key "employee_pay_rolls", "pay_rolls"
  add_foreign_key "employees", "pay_schemes"
  add_foreign_key "payment_record_time_logs", "payment_record_pay_schemes"
  add_foreign_key "payment_record_time_logs", "payment_records"
  add_foreign_key "payment_records", "employees"
  add_foreign_key "payment_records", "pay_rolls"
  add_foreign_key "payment_records", "payment_record_pay_schemes"
  add_foreign_key "time_logs", "employees"
  add_foreign_key "time_logs", "pay_schemes"
  add_foreign_key "time_logs", "payment_records"
end
