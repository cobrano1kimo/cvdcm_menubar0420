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

ActiveRecord::Schema.define(version: 20200522021311) do

  create_table "CompanyTax", primary_key: "tax_id", id: :integer, force: :cascade do |t|
    t.char "cust_id", limit: 5
    t.varchar "cust_taxid", limit: 10
    t.varchar "tax_name", limit: 50
    t.varchar "tax_note", limit: 225
    t.varchar "note_mix", limit: 275
  end

  create_table "accounts", force: :cascade do |t|
    t.string "acc_kind"
    t.string "acc_no"
    t.string "acc_date"
    t.integer "acc_cost"
    t.string "cust_id", limit: 5
    t.string "cust_type"
    t.datetime "cre_date"
    t.string "acc_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "articles", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", primary_key: "cust_id", id: :string, limit: 5, default: "", force: :cascade do |t|
    t.string "cust_name"
    t.string "cust_nick"
    t.string "cust_stat"
    t.string "won_staff"
    t.string "cust_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "excel", id: false, force: :cascade do |t|
    t.varchar "cust_id", limit: 50
    t.varchar "cust_type", limit: 50
    t.varchar "acc_kind", limit: 50
    t.varchar "job_no", limit: 50
    t.varchar "acc_date", limit: 50
    t.varchar "cust_name", limit: 50
    t.varchar "acc_cost", limit: 50
    t.varchar "cust_taxid", limit: 50
    t.varchar "tax_name", limit: 50
    t.varchar "cust_stat", limit: 50
    t.varchar "note_all", limit: 50
    t.varchar "won_staff", limit: 50
  end

  create_table "excel_data", id: false, force: :cascade do |t|
    t.varchar "cust_id", limit: 50
    t.varchar "cust_type", limit: 50
    t.varchar "acc_kind", limit: 50
    t.varchar "job_no", limit: 50
    t.varchar "acc_date", limit: 50
    t.varchar "cust_name", limit: 50
    t.varchar "acc_cost", limit: 50
    t.varchar "cust_taxid", limit: 50
    t.varchar "tax_name", limit: 120
    t.varchar "cust_stat", limit: 50
    t.varchar "note_all", limit: 50
    t.varchar "won_staff", limit: 50
  end

  create_table "histories", force: :cascade do |t|
    t.string "acc_kind"
    t.string "no_bef"
    t.string "no_aft"
    t.string "acc_date"
    t.integer "cost_bef"
    t.integer "cost_aft"
    t.string "cust_id"
    t.string "mark"
    t.string "user_id"
    t.string "type_bef"
    t.string "type_aft"
    t.string "note_bef"
    t.string "note_aft"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "large_classifications", id: false, force: :cascade do |t|
    t.string "large_classification_id", limit: 3, null: false
    t.string "description", limit: 120
    t.string "created_staff", limit: 20
    t.string "updated_staff", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ldap_departments", id: false, force: :cascade do |t|
    t.bigint "usncreated", null: false
    t.string "name"
    t.datetime "whencreated"
    t.datetime "whenchanged"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ldap_role_users", id: false, force: :cascade do |t|
    t.integer "department_id"
    t.integer "role_id"
    t.integer "user_id"
    t.string "department"
    t.string "role"
    t.string "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ldap_roles", id: false, force: :cascade do |t|
    t.bigint "usncreated", null: false
    t.string "name"
    t.string "department"
    t.string "mail"
    t.datetime "whencreated"
    t.datetime "whenchanged"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ldap_users", id: false, force: :cascade do |t|
    t.bigint "usncreated", null: false
    t.string "samaccountname"
    t.string "name"
    t.string "department"
    t.string "title"
    t.string "mail"
    t.string "info"
    t.string "description"
    t.string "telephonenumber"
    t.string "facsimiletelephonenumber"
    t.datetime "whencreated"
    t.datetime "whenchanged"
    t.datetime "accountexpires"
    t.boolean "is_disable_account"
    t.boolean "is_left_job"
    t.boolean "is_retired"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menubars", primary_key: "menu_id", id: :string, limit: 8, default: nil, force: :cascade do |t|
    t.string "menu_name", limit: 40
    t.string "parent_menu_id", limit: 6
    t.integer "menu_sn"
    t.string "program_id"
    t.string "program_url"
    t.integer "lock_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "small_classifications", id: false, force: :cascade do |t|
    t.string "large_classification_id", limit: 3, null: false
    t.string "medium_classification_id", limit: 3, null: false
    t.string "small_classification_id", limit: 3, null: false
    t.string "description", limit: 120
    t.string "remark", limit: 240
    t.string "created_staff", limit: 20
    t.string "updated_staff", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.string "login"
    t.string "group"
    t.string "won_staff"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :bigint, default: nil, force: :cascade do |t|
    t.string "login", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "accounts", "customers", column: "cust_id", primary_key: "cust_id", name: "FK__accounts__cust_i__6B24EA82"
end
