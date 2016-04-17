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

ActiveRecord::Schema.define(version: 20160417200452) do

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "adress"
    t.integer  "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.datetime "date"
    t.string   "plate"
    t.datetime "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "company_id"
    t.decimal  "vat"
    t.decimal  "total"
    t.string   "reason"
    t.decimal  "taxable"
  end

  add_index "invoices", ["company_id"], name: "index_invoices_on_company_id"

  create_table "payments", force: :cascade do |t|
    t.string   "method_of_payment"
    t.datetime "date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "invoice_id"
    t.decimal  "paid"
  end

  add_index "payments", ["invoice_id"], name: "index_payments_on_invoice_id"

end
