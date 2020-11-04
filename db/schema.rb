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

ActiveRecord::Schema.define(version: 20201030082431) do

  create_table "CompanyTax", primary_key: "tax_id", id: :integer, force: :cascade do |t|
    t.char "cust_id", limit: 5
    t.varchar "cust_taxid", limit: 10
    t.varchar "tax_name", limit: 50
    t.varchar "tax_note", limit: 225
    t.varchar "note_mix", limit: 275
  end

  create_table "WCM_20200918_BOX", id: false, force: :cascade do |t|
    t.varchar "cm00", limit: 254
    t.varchar "CM01", limit: 254
    t.varchar "cm24", limit: 254
    t.varchar "cm04", limit: 254
    t.varchar "CM28", limit: 254
    t.varchar "cm31", limit: 254
  end

  create_table "WKandKwInvoice_20200907_BOX", id: false, force: :cascade do |t|
    t.varchar "acc_kind", limit: 254
    t.varchar "acc_no", limit: 254
    t.varchar "acc_date", limit: 254
    t.varchar "acc_cost", limit: 254
    t.varchar "cust_id", limit: 254
    t.varchar "cust_type", limit: 254
    t.varchar "cre_date", limit: 254
    t.varchar "acc_note", limit: 254
    t.varchar "created_at", limit: 254
    t.varchar "updated_at", limit: 254
  end

  create_table "WTemp20200907_KandKInovice", force: :cascade do |t|
    t.string "acc_kind"
    t.string "acc_no"
    t.string "acc_date"
    t.integer "acc_cost"
    t.string "cust_id", limit: 5
    t.string "cust_type"
    t.datetime "cre_date"
    t.string "acc_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "Wdoris_20200918_BOX", id: false, force: :cascade do |t|
    t.varchar "acc_kind", limit: 254
    t.varchar "acc_no", limit: 254
    t.varchar "acc_date", limit: 254
    t.varchar "acc_cost", limit: 254
    t.varchar "cust_id", limit: 254
    t.varchar "cust_type", limit: 254
    t.varchar "cre_date", limit: 254
    t.varchar "acc_note", limit: 254
    t.varchar "created_at", limit: 254
    t.varchar "updated_at", limit: 254
  end

