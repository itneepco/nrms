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

ActiveRecord::Schema.define(version: 20170113073320) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_risk_registers", force: :cascade do |t|
    t.integer "risk_register_id"
    t.integer "category_id"
  end

  add_index "categories_risk_registers", ["category_id"], name: "index_categories_risk_registers_on_category_id"
  add_index "categories_risk_registers", ["risk_register_id"], name: "index_categories_risk_registers_on_risk_register_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "designations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "full_name"
  end

  create_table "risk_mitigations", force: :cascade do |t|
    t.integer  "risk_register_id"
    t.text     "mitigation_step"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "risk_mitigations", ["risk_register_id"], name: "index_risk_mitigations_on_risk_register_id"

  create_table "risk_registers", force: :cascade do |t|
    t.string   "risk_no"
    t.integer  "project_id"
    t.text     "description"
    t.string   "probability"
    t.string   "impact"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.date     "target_date"
    t.boolean  "status",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "mitigation_plan"
  end

  add_index "risk_registers", ["project_id"], name: "index_risk_registers_on_project_id"
  add_index "risk_registers", ["risk_no"], name: "index_risk_registers_on_risk_no"

  create_table "risk_registers_users", force: :cascade do |t|
    t.integer "risk_register_id"
    t.integer "user_id"
  end

  add_index "risk_registers_users", ["risk_register_id"], name: "index_risk_registers_users_on_risk_register_id"
  add_index "risk_registers_users", ["user_id"], name: "index_risk_registers_users_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "mid_name"
    t.string   "last_name"
    t.integer  "designation_id"
    t.string   "department"
    t.integer  "project_id"
    t.string   "password_digest"
    t.integer  "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["designation_id"], name: "index_users_on_designation_id"
  add_index "users", ["project_id"], name: "index_users_on_project_id"

  create_table "users_risk_registers", force: :cascade do |t|
    t.integer "risk_register_id"
    t.integer "user_id"
  end

  add_index "users_risk_registers", ["risk_register_id"], name: "index_users_risk_registers_on_risk_register_id"
  add_index "users_risk_registers", ["user_id"], name: "index_users_risk_registers_on_user_id"

end
