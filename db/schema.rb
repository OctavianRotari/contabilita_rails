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

ActiveRecord::Schema.define(version: 20160909081105) do

  create_table "category_of_companies", force: :cascade do |t|
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "adress"
    t.integer  "number"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "category_of_company_id"
  end

  add_index "companies", ["category_of_company_id"], name: "index_companies_on_category_of_company_id"

  create_table "invoices", force: :cascade do |t|
    t.datetime "date_of_issue"
    t.datetime "deadline"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "company_id"
    t.decimal  "total_vat"
    t.decimal  "total"
    t.string   "reason"
    t.decimal  "total_taxable"
    t.integer  "vehicle_id"
    t.string   "type_of_invoice"
  end

  add_index "invoices", ["company_id"], name: "index_invoices_on_company_id"
  add_index "invoices", ["vehicle_id"], name: "index_invoices_on_vehicle_id"

  create_table "payments", force: :cascade do |t|
    t.string   "method_of_payment"
    t.datetime "payment_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "invoice_id"
    t.decimal  "paid"
  end

  add_index "payments", ["invoice_id"], name: "index_payments_on_invoice_id"

  create_table "taxable_vat_fields", force: :cascade do |t|
    t.decimal  "taxable"
    t.decimal  "vat_rate"
    t.integer  "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taxable_vat_fields", ["invoice_id"], name: "index_taxable_vat_fields_on_invoice_id"

  create_table "users", force: :cascade do |t|
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "vehicles", force: :cascade do |t|
    t.string   "plate"
    t.string   "type_of_vehicle"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
