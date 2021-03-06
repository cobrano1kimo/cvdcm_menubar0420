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

ActiveRecord::Schema.define(version: 20201126090020) do

  create_table "CompanyTax", primary_key: "tax_id", id: :integer, force: :cascade do |t|
    t.char "cust_id", limit: 5
    t.varchar "cust_taxid", limit: 10
    t.varchar "tax_name", limit: 50
    t.varchar "tax_note", limit: 225
    t.varchar "note_mix", limit: 275
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

  create_table "Wdoise_20201012_BOX", id: false, force: :cascade do |t|
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

  create_table "Weilien_20200915_BOX", id: false, force: :cascade do |t|
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

  create_table "Wkaren09_20201019_BOX", id: false, force: :cascade do |t|
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

  create_table "Wsabrina_20200923_BOX", id: false, force: :cascade do |t|
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
    t.string "clo_mark", limit: 1
    t.datetime "clo_date"
  end

  create_table "closements", id: false, force: :cascade do |t|
    t.integer "close_day"
  end

  create_table "customer_tmps", primary_key: "cust_id", id: :string, limit: 5, default: "", force: :cascade do |t|
    t.string "cust_name"
    t.string "cust_stat"
    t.string "won_staff"
    t.string "cust_payment", limit: 2
    t.string "cust_note"
    t.string "paymonth01", limit: 2
    t.string "paymonth02", limit: 2
    t.string "paymonth03", limit: 2
    t.string "paymonth04", limit: 2
    t.string "paymonth05", limit: 2
    t.string "paymonth06", limit: 2
    t.string "paymonth07", limit: 2
    t.string "paymonth08", limit: 2
    t.string "paymonth09", limit: 2
    t.string "paymonth10", limit: 2
    t.string "paymonth11", limit: 2
    t.string "paymonth12", limit: 2
  end

  create_table "customers", primary_key: "cust_id", id: :string, limit: 5, default: nil, force: :cascade do |t|
    t.string "cust_name"
    t.string "cust_nick"
    t.string "cust_stat"
    t.string "won_staff"
    t.string "cust_note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cust_payment", limit: 2
    t.string "cust_payday", limit: 2
    t.string "paymonth01", limit: 2
    t.string "paymonth02", limit: 2
    t.string "paymonth03", limit: 2
    t.string "paymonth04", limit: 2
    t.string "paymonth05", limit: 2
    t.string "paymonth06", limit: 2
    t.string "paymonth07", limit: 2
    t.string "paymonth08", limit: 2
    t.string "paymonth09", limit: 2
    t.string "paymonth10", limit: 2
    t.string "paymonth11", limit: 2
    t.string "paymonth12", limit: 2
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
    t.varchar "operator", limit: 400
  end

  create_table "kk_customer", id: false, force: :cascade do |t|
    t.varchar "cust_id", limit: 50
    t.varchar "cust_name", limit: 50
    t.varchar "cust_note", limit: 50
    t.varchar "won_staff", limit: 50
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
    t.string "email", limit: 256
  end

  create_table "users", id: :integer, force: :cascade do |t|
    t.string "login", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vancustomer_from_cms", primary_key: "CM00", id: :string, limit: 5, default: "", force: :cascade do |t|
    t.string "CM01"
    t.string "CM02"
    t.string "CM03"
    t.string "CM04"
    t.string "CM05"
    t.string "CM06"
    t.string "CM07"
    t.string "CM08"
    t.string "CM09"
    t.string "CM10"
    t.string "CM11"
    t.string "CM12"
    t.string "CM13"
    t.string "CM14"
    t.string "CM15"
    t.string "CM16"
    t.string "CM17"
    t.string "CM18"
    t.string "CM19"
    t.string "CM20"
    t.string "CM21"
    t.string "CM22"
    t.string "CM23"
    t.string "CM24"
    t.integer "CM25"
    t.string "CM26"
    t.integer "CM27"
    t.string "CM28"
    t.string "CM29"
    t.string "CM30"
    t.string "CM31"
    t.string "CM32"
    t.string "CM33"
    t.string "CM34"
    t.string "CRE_USERID"
    t.string "CRE_DTIME"
    t.string "UPD_USERID"
    t.string "UPD_DTIME"
    t.string "CM35"
    t.string "CM36"
    t.string "CM37"
  end

  add_foreign_key "accounts", "customers", column: "cust_id", primary_key: "cust_id", name: "fk_customer_id"
end
